CREATE OR ALTER PROCEDURE sp_CreateOrder
    @user_id INT,
    @address_id INT,
    @product_id INT,
    @quantity INT,
    @discount_id INT = NULL,
    @payment_method INT,
    @order_id INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @total_amount DECIMAL(15,3);
    DECLARE @discount_amount DECIMAL(15,3) = 0;
    DECLARE @product_price DECIMAL(15,3);
    DECLARE @stock_quantity INT;
    DECLARE @discount_value DECIMAL(15,3);
    DECLARE @discount_type INT;
    DECLARE @minimum_order_value DECIMAL(15,3);
    DECLARE @is_active BIT;
    DECLARE @start_date DATE;
    DECLARE @end_date DATE;
    DECLARE @usage_limit INT;
    DECLARE @used_count INT;
    DECLARE @error_message NVARCHAR(255);
    DECLARE @shipping_fee DECIMAL(15,3) = 30000;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Kiểm tra địa chỉ hợp lệ
        IF NOT EXISTS (SELECT 1 FROM Address WHERE address_id = @address_id AND user_id = @user_id)
        BEGIN
            SET @error_message = 'Invalid address for user';
            THROW 50001, @error_message, 1;
        END

        -- Kiểm tra sản phẩm và số lượng tồn kho
        SELECT @product_price = price, @stock_quantity = stock_quantity
        FROM Products
        WHERE product_id = @product_id AND is_active = 1;

        IF @product_price IS NULL
        BEGIN
            SET @error_message = 'Product not found or inactive';
            THROW 50002, @error_message, 1;
        END

        IF @stock_quantity < @quantity
        BEGIN
            SET @error_message = 'Insufficient stock';
            THROW 50003, @error_message, 1;
        END

        -- Tính toán giá sản phẩm
        DECLARE @product_total_price DECIMAL(15,3) = @product_price * @quantity;

        -- Kiểm tra mã giảm giá (nếu có)
        IF @discount_id IS NOT NULL
        BEGIN
            SELECT 
                @discount_value = discount_value,
                @discount_type = discount_type,
                @minimum_order_value = minimum_order_value,
                @is_active = is_active,
                @start_date = start_date,
                @end_date = end_date,
                @usage_limit = usage_limit,
                @used_count = used_count
            FROM Discounts
            WHERE discount_id = @discount_id;

            IF @discount_value IS NULL OR @is_active = 0 OR 
               GETDATE() < @start_date OR GETDATE() > @end_date OR
               (@usage_limit > 0 AND @used_count >= @usage_limit)
            BEGIN
                SET @error_message = 'Invalid or expired discount';
                THROW 50004, @error_message, 1;
            END

            -- Kiểm tra giá trị đơn hàng tối thiểu
            IF @minimum_order_value IS NOT NULL AND @product_total_price < @minimum_order_value
            BEGIN
                SET @error_message = 'Order value does not meet discount requirements';
                THROW 50005, @error_message, 1;
            END

            -- Tính toán giảm giá (tái sử dụng logic từ OrderConfirmServlet)
            IF @discount_type = 1 -- Phần trăm
                SET @discount_amount = @product_total_price * (@discount_value / 100.0);
            ELSE IF @discount_type = 2 -- Cố định
            BEGIN
                SET @discount_amount = @discount_value;
                IF @discount_amount > @product_total_price
                    SET @discount_amount = @product_total_price;
            END
        END

        -- Tính tổng tiền
        SET @total_amount = @product_total_price - @discount_amount + @shipping_fee;

        -- Thêm vào bảng Orders
        INSERT INTO Orders (user_id, order_date, status, total_amount, discount_id, discount_amount, address_id)
        VALUES (@user_id, GETDATE(), 1, @total_amount, @discount_id, @discount_amount, @address_id);

        -- Lấy order_id
        SET @order_id = SCOPE_IDENTITY();

        -- Thêm vào bảng OrderDetails
        INSERT INTO OrderDetails (order_id, product_id, quantity, price)
        VALUES (@order_id, @product_id, @quantity, @product_price);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        DECLARE @errorMsg NVARCHAR(4000) = ERROR_MESSAGE();
        THROW 50000, @errorMsg, 1;
    END CATCH
END;
GO

CREATE OR ALTER TRIGGER tr_UpdateStockQuantity
ON OrderDetails
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE p
    SET p.stock_quantity = p.stock_quantity - i.quantity
    FROM Products p
    INNER JOIN inserted i ON p.product_id = i.product_id
    WHERE p.stock_quantity >= i.quantity;

    IF @@ROWCOUNT = 0
    BEGIN
        THROW 50006, 'Insufficient stock quantity for product', 1;
    END
END;
GO

CREATE OR ALTER TRIGGER tr_UpdateDiscountUsage
ON Orders
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Cập nhật used_count trong Discounts
    UPDATE d
    SET d.used_count = d.used_count + 1
    FROM Discounts d
    INNER JOIN inserted i ON d.discount_id = i.discount_id
    WHERE i.discount_id IS NOT NULL;

    -- Thêm vào DiscountUsers
    INSERT INTO DiscountUsers (discount_id, user_id, used_at)
    SELECT i.discount_id, i.user_id, GETDATE()
    FROM inserted i
    WHERE i.discount_id IS NOT NULL;
END;
GO