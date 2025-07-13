CREATE OR ALTER PROCEDURE sp_CreateOrder
    @user_id INT,
    @address_id INT,
    @product_id INT,
    @quantity INT,
    @discount_id INT = NULL,
	@shipping_id INT,
	@payment_id INT,
    @order_id INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @product_price DECIMAL(15,3);
    DECLARE @stock_quantity INT;
    DECLARE @discount_value DECIMAL(15,3);
    DECLARE @discount_type INT;
    DECLARE @discount_amount DECIMAL(15,3) = 0;
    DECLARE @total_amount DECIMAL(15,3);
    DECLARE @error_message NVARCHAR(255);

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Kiểm tra địa chỉ có thuộc về user không
        IF NOT EXISTS (
            SELECT 1 FROM Address 
            WHERE address_id = @address_id AND user_id = @user_id
        )
        BEGIN
            SET @error_message = 'Invalid address for user';
            THROW 50001, @error_message, 1;
        END

        -- Lấy giá và kiểm tra tồn kho sản phẩm
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

        -- Tính tổng tiền sản phẩm
        DECLARE @product_total_price DECIMAL(15,3) = @product_price * @quantity;

        -- Tính giảm giá nếu có
        IF @discount_id IS NOT NULL
        BEGIN
            SELECT 
                @discount_value = discount_value,
                @discount_type = discount_type
            FROM Discounts
            WHERE discount_id = @discount_id AND is_active = 1 
                  AND GETDATE() BETWEEN start_date AND end_date;

            IF @discount_value IS NULL
            BEGIN
                SET @error_message = 'Invalid or expired discount';
                THROW 50004, @error_message, 1;
            END

            IF @discount_type = 1 -- % giảm
                SET @discount_amount = @product_total_price * (@discount_value / 100.0);
            ELSE IF @discount_type = 2 -- giảm cố định
            BEGIN
                SET @discount_amount = @discount_value;
                IF @discount_amount > @product_total_price
                    SET @discount_amount = @product_total_price;
            END
        END

        -- Tổng tiền cần thanh toán
        SET @total_amount = @product_total_price - @discount_amount;

        -- Insert đơn hàng
        INSERT INTO Orders (
            user_id, order_date, status, total_amount, 
            discount_id, discount_amount, address_id, shipping_id, payment_id
        ) VALUES (
            @user_id, GETDATE(), 1, @total_amount, 
            @discount_id, @discount_amount, @address_id, shipping_id, payment_id
        );

        SET @order_id = SCOPE_IDENTITY();

        -- Insert chi tiết đơn hàng
        INSERT INTO OrderDetails (
            order_id, product_id, quantity, price
        ) VALUES (
            @order_id, @product_id, @quantity, @product_price
        );


        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW 50006, 'Can not create order', 1;
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