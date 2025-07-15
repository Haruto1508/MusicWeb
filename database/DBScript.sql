-- Tạo database nếu chưa tồn tại
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'MusicShop')
BEGIN
    CREATE DATABASE MusicShop;
END;
GO

USE MusicShop;
GO

-- ROLES TABLE
CREATE TABLE Roles (
    role_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(50) UNIQUE NOT NULL,
    description NVARCHAR(255)
);
GO

-- USERS TABLE
CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    full_name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    password NVARCHAR(128) NOT NULL,
    phone NVARCHAR(20),
    role_id INT DEFAULT 2,
    created_at DATETIME DEFAULT GETDATE(),
    gender INT DEFAULT NULL CHECK (gender IN (1,2,3)), -- 1: Nam, 2: Nữ, 3: Khác
    birthdate DATE DEFAULT '1990-01-01',
    image_url NVARCHAR(255) DEFAULT 'default.png',
    is_active BIT DEFAULT 1,
    account NVARCHAR(100) UNIQUE NOT NULL,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);
GO

-- ADDRESS TABLE
CREATE TABLE Address (
    address_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    street NVARCHAR(255) NOT NULL,
    ward NVARCHAR(100),
    district NVARCHAR(100),
    city NVARCHAR(100) NOT NULL,
    type NVARCHAR(50),
	is_deleted BIT NOT NULL DEFAULT 0,
    is_default BIT DEFAULT 0,
    receiver_name NVARCHAR(255),
    receiver_phone NVARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);
GO

-- CATEGORIES TABLE
CREATE TABLE Categories (
    category_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) UNIQUE NOT NULL,
    description NVARCHAR(MAX)
);
GO

-- SUBCATEGORIES TABLE
CREATE TABLE Subcategories (
    subcategory_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);
GO

-- BRANDS TABLE
CREATE TABLE Brands (
    brand_id INT PRIMARY KEY IDENTITY(1,1),
    brand_name NVARCHAR(100) NOT NULL
);
GO

-- DISCOUNTS TABLE
CREATE TABLE Discounts (
    discount_id INT PRIMARY KEY IDENTITY(1,1),
    code NVARCHAR(50) UNIQUE NOT NULL,
    description NVARCHAR(MAX),
    discount_type INT DEFAULT 2 CHECK (discount_type IN (1, 2)), -- 1: %, 2: fixed
    discount_value DECIMAL(15,3) CHECK (discount_value >= 0),
    start_date DATE,
    end_date DATE,
    minimum_order_value DECIMAL(15,3),
    usage_limit INT,
    used_count INT DEFAULT 0,
    is_active BIT DEFAULT 1
);
GO

-- PRODUCTS TABLE
CREATE TABLE Products (
    product_id INT PRIMARY KEY IDENTITY(1,1),
    discount_id INT,
    name NVARCHAR(150) NOT NULL,
    description NVARCHAR(MAX),
    price DECIMAL(15,3) NOT NULL,
    stock_quantity INT CHECK (stock_quantity >= 0),
    category_id INT,
    brand_id INT,
    image_url NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE(),
    sold_quantity INT DEFAULT 0,
    is_active BIT DEFAULT 1,
	origin_country NVARCHAR(100),
	manufacturing_year INT,
	material NVARCHAR(100),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    FOREIGN KEY (discount_id) REFERENCES Discounts(discount_id),
    FOREIGN KEY (brand_id) REFERENCES Brands(brand_id)
);
GO

-- PRODUCT IMAGES TABLE
CREATE TABLE ProductImages (
    image_id INT PRIMARY KEY IDENTITY(1,1),
    product_id INT,
    image_url NVARCHAR(MAX) NOT NULL,
    caption NVARCHAR(255),
    is_primary BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);
GO


-- PAYMENTS TABLE
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    payment_method INT DEFAULT 2 CHECK (payment_method IN (1, 2)) -- 1 credit card, 2 money  
);
GO

CREATE TABLE ShippingFees (
	shipping_fee_id INT PRIMARY KEY IDENTITY(1,1),
    shipping_fee DECIMAL(15,3) NOT NULL CHECK (shipping_fee >= 0)
);
GO

-- SHIPPING TABLE
CREATE TABLE Shipping (
    shipping_id INT PRIMARY KEY IDENTITY(1,1),
    shipping_method NVARCHAR(100),
    tracking_number NVARCHAR(100)
);
GO

-- ORDERS TABLE
CREATE TABLE Orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    order_date DATETIME DEFAULT GETDATE(),
    status INT DEFAULT 1 CHECK (status BETWEEN 1 AND 5),
    total_amount DECIMAL(15,3) NOT NULL,
    discount_id INT,
    discount_amount DECIMAL(15,3) DEFAULT 0,
    address_id INT,
	shipping_id INT NOT NULL,
	payment_id INT NOT NULL,
	shipped_date DATETIME,
    estimated_delivery DATETIME,
    FOREIGN KEY (address_id) REFERENCES Address(address_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (discount_id) REFERENCES Discounts(discount_id),
	FOREIGN KEY (payment_id) REFERENCES Payments(payment_id),
	FOREIGN KEY (shipping_id) REFERENCES Shipping(shipping_id)
);
GO

-- ORDER DETAILS TABLE
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    product_id INT,
	price DECIMAL(15,3) NOT NULL,
	quantity INT DEFAULT 1 NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
GO

-- CART TABLE
CREATE TABLE Carts (
    cart_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    product_id INT,
    quantity INT NOT NULL,
    added_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
    CONSTRAINT unique_cart_user_product UNIQUE (user_id, product_id)
);
GO

-- REVIEWS TABLE
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY IDENTITY(1,1),
    product_id INT,
    user_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);
GO

-- DISCOUNT USERS TABLE
CREATE TABLE DiscountUsers (
    id INT PRIMARY KEY IDENTITY(1,1),
    discount_id INT,
    user_id INT,
    used_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (discount_id) REFERENCES Discounts(discount_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);
GO


-- INDEXES
CREATE INDEX idx_users_email ON Users(email);
CREATE INDEX idx_discounts_code ON Discounts(code);
CREATE INDEX idx_products_category_id ON Products(category_id);
CREATE INDEX idx_products_brand_id ON Products(brand_id);
CREATE INDEX idx_orderdetails_order_id ON OrderDetails(order_id);
CREATE INDEX idx_productimages_product_id ON ProductImages(product_id);
CREATE INDEX idx_orders_user_id ON Orders(user_id);
CREATE INDEX idx_orderdetails_product_id ON OrderDetails(product_id);
CREATE INDEX idx_carts_product_id ON Carts(product_id);
CREATE INDEX idx_reviews_product_id ON Reviews(product_id);
GO

-- Procedure
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
			@discount_id, @discount_amount, @address_id, @shipping_id, @payment_id
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

-- Role
INSERT INTO Roles (name, description) VALUES
('Admin', 'Administrator role with full permissions'),
('User', 'Registered customer with standard permissions');

-- USERS
INSERT INTO Users (full_name, email, password, phone, role_id, gender, birthdate, account)
VALUES 
('Admin User', 'admin@example.com', 'admin123', '1234567890', 1, 1, '1985-01-01', 'adminuser'),
('Rem', 'rem@gmail.com', '93a6be90e81a902c15ab3103e2990ecb', '0987654321', 2, 1, '1995-06-15', 'remcute');  -- user_id = 2

-- Category
INSERT INTO Categories (name, description) VALUES
('Guitar', 'All types of guitars including acoustic, electric, bass, etc.'),
('Piano', 'Digital, acoustic and grand pianos.'),
('Violin', 'Various violins for all skill levels.');


-- Brand Guitar
INSERT INTO Brands (brand_name) VALUES
('Fender'),
('Gibson'),
('Yamaha'),
('Ibanez'),
('Epiphone'),
('Taylor'),
('Martin'),
('Gretsch'),
('Jackson'),
('ESP');

-- Brand Piano
INSERT INTO Brands (brand_name) VALUES
('Yamaha'),
('Kawai'),
('Steinway & Sons'),
('Casio'),
('Roland'),
('Korg'),
('Bösendorfer'),
('Samick'),
('Petrof'),
('Young Chang');

-- Brand Violin 
INSERT INTO Brands (brand_name) VALUES
('Stentor'),
('Cremona'),
('Yamaha'),
('Fiddlerman'),
('Cecilio'),
('Eastman'),
('D Z Strad'),
('Scott Cao'),
('Gliga'),
('Knilling');

-- Subcategory Guitar
INSERT INTO Subcategories (name, category_id) VALUES
('Acoustic', 1),
('Electric', 1),
('Classic', 1),
('Bass', 1);

-- Subcategry Piano
INSERT INTO Subcategories (name, category_id) VALUES
('Grand Piano', 2),
('Upright Piano', 2),
('Digital Piano', 2),
('Keyboard', 2);


-- Subcategory Violin
INSERT INTO Subcategories (name, category_id) VALUES
('Acoustic', 3),
('Electric', 3),
('Semi-electric', 3);

-- Discount
INSERT INTO Discounts (code, description, discount_type, discount_value, start_date, end_date, minimum_order_value, usage_limit)
VALUES
('WELCOME10', N'10% off for new customers', 1, 10.0, '2025-01-01', '2026-01-01', 0, 100),
('SUMMER50', N'Giảm 50k cho đơn hàng trên 500k', 2, 50000, '2025-06-01', '2025-08-31', 500000, 200),
('VIP20', N'20% for VIP customers', 1, 20.0, '2025-01-01', '2026-12-31', 1000000, 50);

-- Payment
INSERT INTO Payments (payment_method) VALUES
(1), -- Credit Card
(2); -- Cash

-- Shipping fees
INSERT INTO ShippingFees (shipping_fee) VALUES
(20000),  -- Giao tiêu chuẩn
(40000),  -- Giao nhanh
(60000);  -- Hỏa tốc

-- Shipping
INSERT INTO Shipping (shipping_method, tracking_number) VALUES
('Standard Delivery', NULL),
('Express Delivery', NULL),
('Same Day Delivery', NULL);

-- Product
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Three Guitar Model 964', N'This is a high-quality guitar suitable for all levels.', 6393434.291, 58, 1, 1, 'guitar5.jpg', N'South Korea', 2021, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Image Guitar Model 902', N'This is a high-quality guitar suitable for all levels.', 12617940.651, 66, 1, 6, 'guitar10.jpg', N'Japan', 2022, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Son Guitar Model 388', N'This is a high-quality guitar suitable for all levels.', 2956440.99, 17, 1, 10, 'guitar5.jpg', N'South Korea', 2023, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Voice Guitar Model 250', N'This is a high-quality guitar suitable for all levels.', 5342065.97, 98, 1, 2, 'guitar6.jpg', N'Germany', 2022, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Kitchen Guitar Model 462', N'This is a high-quality guitar suitable for all levels.', 7078405.696, 83, 1, 4, 'guitar9.jpg', N'Germany', 2021, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Amount Guitar Model 366', N'This is a high-quality guitar suitable for all levels.', 1871914.232, 75, 1, 1, 'guitar2.jpg', N'Vietnam', 2024, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Event Guitar Model 827', N'This is a high-quality guitar suitable for all levels.', 12547829.68, 90, 1, 1, 'guitar10.jpg', N'Germany', 2024, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Much Guitar Model 349', N'This is a high-quality guitar suitable for all levels.', 11223900.069, 95, 1, 2, 'guitar4.jpg', N'South Korea', 2019, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Mention Guitar Model 922', N'This is a high-quality guitar suitable for all levels.', 14545563.504, 74, 1, 8, 'guitar2.jpg', N'USA', 2020, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Interview Guitar Model 601', N'This is a high-quality guitar suitable for all levels.', 2526809.843, 75, 1, 5, 'guitar2.jpg', N'South Korea', 2020, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Why Guitar Model 308', N'This is a high-quality guitar suitable for all levels.', 14493739.644, 82, 1, 9, 'guitar10.jpg', N'China', 2021, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Step Guitar Model 710', N'This is a high-quality guitar suitable for all levels.', 12171090.27, 45, 1, 10, 'guitar4.jpg', N'China', 2019, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Themselves Guitar Model 941', N'This is a high-quality guitar suitable for all levels.', 3614213.396, 83, 1, 5, 'guitar8.jpg', N'USA', 2018, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Floor Guitar Model 875', N'This is a high-quality guitar suitable for all levels.', 2823142.307, 24, 1, 1, 'guitar2.jpg', N'Vietnam', 2024, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Me Guitar Model 799', N'This is a high-quality guitar suitable for all levels.', 6478144.703, 95, 1, 9, 'guitar5.jpg', N'South Korea', 2024, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Help Guitar Model 969', N'This is a high-quality guitar suitable for all levels.', 4012818.132, 91, 1, 10, 'guitar7.jpg', N'South Korea', 2020, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Past Guitar Model 604', N'This is a high-quality guitar suitable for all levels.', 10243435.301, 94, 1, 6, 'guitar2.jpg', N'China', 2022, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Wait Guitar Model 598', N'This is a high-quality guitar suitable for all levels.', 9219045.824, 47, 1, 4, 'guitar4.jpg', N'USA', 2023, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Whatever Guitar Model 219', N'This is a high-quality guitar suitable for all levels.', 10874663.614, 52, 1, 3, 'guitar6.jpg', N'Germany', 2024, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Discover Guitar Model 203', N'This is a high-quality guitar suitable for all levels.', 11963659.138, 94, 1, 4, 'guitar1.jpg', N'South Korea', 2023, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Mother Guitar Model 716', N'This is a high-quality guitar suitable for all levels.', 10528247.856, 8, 1, 2, 'guitar4.jpg', N'South Korea', 2024, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Chair Guitar Model 222', N'This is a high-quality guitar suitable for all levels.', 6476931.731, 52, 1, 2, 'guitar1.jpg', N'South Korea', 2018, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Father Guitar Model 289', N'This is a high-quality guitar suitable for all levels.', 11053586.57, 66, 1, 4, 'guitar1.jpg', N'Vietnam', 2018, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Challenge Guitar Model 535', N'This is a high-quality guitar suitable for all levels.', 9688399.594, 38, 1, 2, 'guitar4.jpg', N'USA', 2023, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Someone Guitar Model 458', N'This is a high-quality guitar suitable for all levels.', 7104961.071, 12, 1, 9, 'guitar8.jpg', N'USA', 2022, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Beyond Guitar Model 816', N'This is a high-quality guitar suitable for all levels.', 14835292.082, 30, 1, 5, 'guitar6.jpg', N'Vietnam', 2021, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Present Guitar Model 273', N'This is a high-quality guitar suitable for all levels.', 10767758.991, 31, 1, 1, 'guitar3.jpg', N'Japan', 2020, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Successful Guitar Model 356', N'This is a high-quality guitar suitable for all levels.', 2640979.814, 61, 1, 3, 'guitar1.jpg', N'Germany', 2023, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Enough Guitar Model 682', N'This is a high-quality guitar suitable for all levels.', 13247265.72, 44, 1, 6, 'guitar7.jpg', N'Vietnam', 2020, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Where Guitar Model 674', N'This is a high-quality guitar suitable for all levels.', 10671518.61, 63, 1, 2, 'guitar6.jpg', N'Vietnam', 2018, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'No Guitar Model 387', N'This is a high-quality guitar suitable for all levels.', 2887726.496, 66, 1, 6, 'guitar10.jpg', N'China', 2023, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Season Guitar Model 704', N'This is a high-quality guitar suitable for all levels.', 14256681.699, 86, 1, 10, 'guitar3.jpg', N'Vietnam', 2020, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Take Guitar Model 866', N'This is a high-quality guitar suitable for all levels.', 6801851.836, 88, 1, 2, 'guitar1.jpg', N'South Korea', 2019, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Play Guitar Model 442', N'This is a high-quality guitar suitable for all levels.', 3241116.906, 33, 1, 8, 'guitar7.jpg', N'Vietnam', 2023, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Week Guitar Model 995', N'This is a high-quality guitar suitable for all levels.', 6801689.554, 56, 1, 10, 'guitar7.jpg', N'Vietnam', 2023, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Choice Guitar Model 269', N'This is a high-quality guitar suitable for all levels.', 7234930.656, 38, 1, 3, 'guitar8.jpg', N'South Korea', 2021, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Force Guitar Model 718', N'This is a high-quality guitar suitable for all levels.', 11576786.742, 9, 1, 8, 'guitar6.jpg', N'China', 2024, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Bit Guitar Model 151', N'This is a high-quality guitar suitable for all levels.', 12326642.003, 58, 1, 4, 'guitar9.jpg', N'Vietnam', 2018, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Show Guitar Model 233', N'This is a high-quality guitar suitable for all levels.', 14815500.723, 56, 1, 7, 'guitar6.jpg', N'USA', 2019, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Back Guitar Model 834', N'This is a high-quality guitar suitable for all levels.', 11566553.489, 91, 1, 9, 'guitar10.jpg', N'USA', 2019, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Way Guitar Model 722', N'This is a high-quality guitar suitable for all levels.', 10089715.949, 43, 1, 5, 'guitar3.jpg', N'USA', 2021, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'To Guitar Model 742', N'This is a high-quality guitar suitable for all levels.', 2138835.835, 40, 1, 8, 'guitar2.jpg', N'China', 2019, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Return Guitar Model 633', N'This is a high-quality guitar suitable for all levels.', 12441825.07, 87, 1, 6, 'guitar2.jpg', N'Japan', 2020, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Give Guitar Model 143', N'This is a high-quality guitar suitable for all levels.', 1569285.831, 92, 1, 5, 'guitar9.jpg', N'China', 2020, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Marriage Guitar Model 969', N'This is a high-quality guitar suitable for all levels.', 1588063.448, 100, 1, 10, 'guitar8.jpg', N'Vietnam', 2023, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Opportunity Guitar Model 755', N'This is a high-quality guitar suitable for all levels.', 7096168.646, 73, 1, 3, 'guitar4.jpg', N'Germany', 2022, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Blood Guitar Model 109', N'This is a high-quality guitar suitable for all levels.', 2938397.289, 39, 1, 6, 'guitar6.jpg', N'China', 2023, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Health Guitar Model 446', N'This is a high-quality guitar suitable for all levels.', 11911836.823, 9, 1, 1, 'guitar5.jpg', N'Japan', 2019, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Leader Guitar Model 396', N'This is a high-quality guitar suitable for all levels.', 6052692.559, 75, 1, 3, 'guitar5.jpg', N'USA', 2021, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Four Guitar Model 345', N'This is a high-quality guitar suitable for all levels.', 14072557.112, 44, 1, 3, 'guitar9.jpg', N'Vietnam', 2018, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Popular Guitar Model 512', N'This is a high-quality guitar suitable for all levels.', 12697836.299, 43, 1, 7, 'guitar2.jpg', N'USA', 2022, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Push Guitar Model 585', N'This is a high-quality guitar suitable for all levels.', 5719127.624, 48, 1, 2, 'guitar8.jpg', N'USA', 2023, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'While Guitar Model 536', N'This is a high-quality guitar suitable for all levels.', 1529541.315, 47, 1, 3, 'guitar3.jpg', N'Vietnam', 2022, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Democratic Guitar Model 925', N'This is a high-quality guitar suitable for all levels.', 14643847.301, 86, 1, 2, 'guitar2.jpg', N'USA', 2019, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Old Guitar Model 326', N'This is a high-quality guitar suitable for all levels.', 1856186.192, 6, 1, 2, 'guitar7.jpg', N'South Korea', 2022, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Me Guitar Model 559', N'This is a high-quality guitar suitable for all levels.', 13882137.558, 79, 1, 4, 'guitar7.jpg', N'USA', 2020, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Level Guitar Model 367', N'This is a high-quality guitar suitable for all levels.', 9193191.818, 26, 1, 7, 'guitar4.jpg', N'China', 2018, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Tree Guitar Model 941', N'This is a high-quality guitar suitable for all levels.', 13090105.22, 94, 1, 1, 'guitar9.jpg', N'Germany', 2024, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Near Guitar Model 306', N'This is a high-quality guitar suitable for all levels.', 2664744.012, 55, 1, 5, 'guitar4.jpg', N'Vietnam', 2018, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Ever Guitar Model 738', N'This is a high-quality guitar suitable for all levels.', 3048962.857, 30, 1, 8, 'guitar7.jpg', N'China', 2022, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Assume Guitar Model 207', N'This is a high-quality guitar suitable for all levels.', 14841658.446, 67, 1, 3, 'guitar10.jpg', N'Germany', 2023, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Support Guitar Model 533', N'This is a high-quality guitar suitable for all levels.', 13287192.161, 68, 1, 6, 'guitar8.jpg', N'Germany', 2023, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Why Guitar Model 995', N'This is a high-quality guitar suitable for all levels.', 3827878.323, 83, 1, 4, 'guitar1.jpg', N'China', 2023, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Official Guitar Model 425', N'This is a high-quality guitar suitable for all levels.', 12453657.333, 9, 1, 9, 'guitar3.jpg', N'China', 2022, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Whole Guitar Model 962', N'This is a high-quality guitar suitable for all levels.', 6306071.521, 42, 1, 8, 'guitar2.jpg', N'USA', 2022, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Address Guitar Model 167', N'This is a high-quality guitar suitable for all levels.', 4151269.151, 10, 1, 5, 'guitar1.jpg', N'Germany', 2020, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Better Guitar Model 919', N'This is a high-quality guitar suitable for all levels.', 3083472.864, 88, 1, 8, 'guitar6.jpg', N'South Korea', 2021, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Serve Guitar Model 614', N'This is a high-quality guitar suitable for all levels.', 1470652.208, 16, 1, 9, 'guitar10.jpg', N'USA', 2023, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Though Guitar Model 872', N'This is a high-quality guitar suitable for all levels.', 3885467.649, 73, 1, 10, 'guitar7.jpg', N'Germany', 2024, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Inside Guitar Model 722', N'This is a high-quality guitar suitable for all levels.', 9209438.378, 7, 1, 1, 'guitar3.jpg', N'China', 2022, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'See Guitar Model 360', N'This is a high-quality guitar suitable for all levels.', 5657601.393, 68, 1, 5, 'guitar5.jpg', N'Germany', 2021, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Thank Guitar Model 163', N'This is a high-quality guitar suitable for all levels.', 3293135.933, 21, 1, 4, 'guitar5.jpg', N'Vietnam', 2024, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Still Guitar Model 156', N'This is a high-quality guitar suitable for all levels.', 14186069.388, 66, 1, 7, 'guitar3.jpg', N'Germany', 2024, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Relate Guitar Model 834', N'This is a high-quality guitar suitable for all levels.', 2142674.963, 94, 1, 3, 'guitar6.jpg', N'Germany', 2018, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Process Guitar Model 577', N'This is a high-quality guitar suitable for all levels.', 6413562.077, 11, 1, 2, 'guitar8.jpg', N'Japan', 2018, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Ability Guitar Model 712', N'This is a high-quality guitar suitable for all levels.', 9643605.932, 85, 1, 6, 'guitar2.jpg', N'Vietnam', 2022, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Population Guitar Model 454', N'This is a high-quality guitar suitable for all levels.', 3729630.689, 67, 1, 2, 'guitar1.jpg', N'South Korea', 2023, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Minute Guitar Model 729', N'This is a high-quality guitar suitable for all levels.', 9852376.961, 48, 1, 2, 'guitar10.jpg', N'China', 2024, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Their Guitar Model 496', N'This is a high-quality guitar suitable for all levels.', 12190776.96, 100, 1, 2, 'guitar9.jpg', N'Japan', 2018, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Trip Guitar Model 555', N'This is a high-quality guitar suitable for all levels.', 6202142.988, 29, 1, 8, 'guitar6.jpg', N'Vietnam', 2018, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Goal Guitar Model 140', N'This is a high-quality guitar suitable for all levels.', 7806311.41, 8, 1, 9, 'guitar10.jpg', N'South Korea', 2019, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Either Guitar Model 195', N'This is a high-quality guitar suitable for all levels.', 11868797.015, 85, 1, 9, 'guitar9.jpg', N'Germany', 2022, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Show Guitar Model 216', N'This is a high-quality guitar suitable for all levels.', 3039665.907, 77, 1, 7, 'guitar2.jpg', N'USA', 2021, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Gas Guitar Model 201', N'This is a high-quality guitar suitable for all levels.', 6812260.321, 24, 1, 1, 'guitar8.jpg', N'Germany', 2023, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Score Guitar Model 130', N'This is a high-quality guitar suitable for all levels.', 7952746.845, 46, 1, 5, 'guitar2.jpg', N'China', 2018, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Truth Guitar Model 467', N'This is a high-quality guitar suitable for all levels.', 10684852.111, 49, 1, 6, 'guitar3.jpg', N'USA', 2024, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'At Guitar Model 938', N'This is a high-quality guitar suitable for all levels.', 6121234.648, 81, 1, 3, 'guitar4.jpg', N'USA', 2019, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Cut Guitar Model 789', N'This is a high-quality guitar suitable for all levels.', 11249420.681, 20, 1, 1, 'guitar5.jpg', N'China', 2023, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Whose Guitar Model 719', N'This is a high-quality guitar suitable for all levels.', 4260083.467, 23, 1, 3, 'guitar8.jpg', N'USA', 2021, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Out Guitar Model 824', N'This is a high-quality guitar suitable for all levels.', 14428401.289, 21, 1, 1, 'guitar4.jpg', N'China', 2020, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Doctor Guitar Model 399', N'This is a high-quality guitar suitable for all levels.', 5148852.983, 75, 1, 6, 'guitar3.jpg', N'South Korea', 2018, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Edge Guitar Model 646', N'This is a high-quality guitar suitable for all levels.', 9131891.342, 25, 1, 7, 'guitar3.jpg', N'Japan', 2024, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Suggest Guitar Model 423', N'This is a high-quality guitar suitable for all levels.', 8116654.272, 35, 1, 3, 'guitar5.jpg', N'China', 2021, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Change Guitar Model 147', N'This is a high-quality guitar suitable for all levels.', 13053644.447, 81, 1, 1, 'guitar7.jpg', N'USA', 2023, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Suggest Guitar Model 235', N'This is a high-quality guitar suitable for all levels.', 6883243.83, 75, 1, 7, 'guitar3.jpg', N'South Korea', 2021, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Of Guitar Model 752', N'This is a high-quality guitar suitable for all levels.', 5963897.624, 36, 1, 8, 'guitar6.jpg', N'Vietnam', 2022, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Line Guitar Model 485', N'This is a high-quality guitar suitable for all levels.', 6720767.097, 58, 1, 6, 'guitar8.jpg', N'Japan', 2020, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Benefit Guitar Model 582', N'This is a high-quality guitar suitable for all levels.', 2274790.833, 28, 1, 2, 'guitar5.jpg', N'USA', 2022, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Be Guitar Model 804', N'This is a high-quality guitar suitable for all levels.', 3154303.708, 94, 1, 8, 'guitar7.jpg', N'Japan', 2024, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Front Guitar Model 542', N'This is a high-quality guitar suitable for all levels.', 3446320.828, 63, 1, 6, 'guitar9.jpg', N'Japan', 2020, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Type Piano Model 746', N'This is a high-quality piano suitable for all levels.', 9922249.341, 66, 2, 14, 'piano5.jpg', N'USA', 2024, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Movie Piano Model 559', N'This is a high-quality piano suitable for all levels.', 9662297.252, 5, 2, 14, 'piano5.jpg', N'USA', 2024, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Worker Piano Model 408', N'This is a high-quality piano suitable for all levels.', 8632913.623, 24, 2, 17, 'piano8.jpg', N'USA', 2023, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Might Piano Model 878', N'This is a high-quality piano suitable for all levels.', 14452853.197, 74, 2, 17, 'piano5.jpg', N'Vietnam', 2018, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Boy Piano Model 376', N'This is a high-quality piano suitable for all levels.', 13372052.262, 10, 2, 11, 'piano5.jpg', N'Germany', 2022, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Fish Piano Model 827', N'This is a high-quality piano suitable for all levels.', 6547289.79, 18, 2, 15, 'piano6.jpg', N'China', 2024, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Ok Piano Model 300', N'This is a high-quality piano suitable for all levels.', 9335738.817, 9, 2, 12, 'piano5.jpg', N'China', 2022, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Film Piano Model 221', N'This is a high-quality piano suitable for all levels.', 8422596.127, 36, 2, 13, 'piano2.jpg', N'Germany', 2024, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Seat Piano Model 389', N'This is a high-quality piano suitable for all levels.', 8277677.431, 78, 2, 19, 'piano4.jpg', N'South Korea', 2018, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Capital Piano Model 749', N'This is a high-quality piano suitable for all levels.', 8610024.122, 99, 2, 15, 'piano5.jpg', N'Germany', 2020, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Officer Piano Model 743', N'This is a high-quality piano suitable for all levels.', 2929378.496, 20, 2, 12, 'piano7.jpg', N'Germany', 2022, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Go Piano Model 242', N'This is a high-quality piano suitable for all levels.', 8834584.112, 43, 2, 16, 'piano8.jpg', N'Vietnam', 2021, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Teacher Piano Model 588', N'This is a high-quality piano suitable for all levels.', 7844014.255, 69, 2, 16, 'piano8.jpg', N'Vietnam', 2018, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Win Piano Model 407', N'This is a high-quality piano suitable for all levels.', 2999360.028, 68, 2, 11, 'piano10.jpg', N'Japan', 2018, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Now Piano Model 582', N'This is a high-quality piano suitable for all levels.', 6473524.693, 6, 2, 19, 'piano2.jpg', N'Vietnam', 2024, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Democrat Piano Model 802', N'This is a high-quality piano suitable for all levels.', 14290329.713, 90, 2, 17, 'piano1.jpg', N'China', 2018, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Successful Piano Model 735', N'This is a high-quality piano suitable for all levels.', 1052365.184, 39, 2, 15, 'piano4.jpg', N'Japan', 2024, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Player Piano Model 394', N'This is a high-quality piano suitable for all levels.', 3676860.761, 60, 2, 18, 'piano6.jpg', N'Germany', 2019, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Officer Piano Model 531', N'This is a high-quality piano suitable for all levels.', 10072069.381, 92, 2, 17, 'piano3.jpg', N'Germany', 2023, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'People Piano Model 636', N'This is a high-quality piano suitable for all levels.', 5425003.766, 31, 2, 13, 'piano8.jpg', N'China', 2024, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Field Piano Model 537', N'This is a high-quality piano suitable for all levels.', 12295844.263, 54, 2, 14, 'piano4.jpg', N'Germany', 2019, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Light Piano Model 827', N'This is a high-quality piano suitable for all levels.', 1697105.711, 54, 2, 11, 'piano4.jpg', N'Vietnam', 2018, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Benefit Piano Model 472', N'This is a high-quality piano suitable for all levels.', 1797866.72, 86, 2, 13, 'piano4.jpg', N'South Korea', 2020, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Pick Piano Model 188', N'This is a high-quality piano suitable for all levels.', 10868931.95, 70, 2, 15, 'piano6.jpg', N'Germany', 2021, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Success Piano Model 747', N'This is a high-quality piano suitable for all levels.', 10755270.684, 90, 2, 19, 'piano7.jpg', N'South Korea', 2021, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Image Piano Model 360', N'This is a high-quality piano suitable for all levels.', 10857635.443, 32, 2, 16, 'piano5.jpg', N'USA', 2018, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Free Piano Model 266', N'This is a high-quality piano suitable for all levels.', 5897231.266, 42, 2, 11, 'piano3.jpg', N'USA', 2024, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Parent Piano Model 796', N'This is a high-quality piano suitable for all levels.', 4110331.115, 82, 2, 17, 'piano9.jpg', N'Japan', 2021, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Effort Piano Model 447', N'This is a high-quality piano suitable for all levels.', 9516463.395, 82, 2, 12, 'piano6.jpg', N'China', 2022, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Fill Piano Model 432', N'This is a high-quality piano suitable for all levels.', 4576997.969, 71, 2, 11, 'piano4.jpg', N'China', 2018, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Create Piano Model 990', N'This is a high-quality piano suitable for all levels.', 8343204.445, 29, 2, 14, 'piano5.jpg', N'Vietnam', 2023, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Current Piano Model 408', N'This is a high-quality piano suitable for all levels.', 5371249.342, 54, 2, 15, 'piano8.jpg', N'China', 2024, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Term Piano Model 345', N'This is a high-quality piano suitable for all levels.', 1623040.619, 75, 2, 12, 'piano1.jpg', N'Germany', 2021, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Culture Piano Model 548', N'This is a high-quality piano suitable for all levels.', 1664559.49, 57, 2, 18, 'piano8.jpg', N'Germany', 2018, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Alone Piano Model 183', N'This is a high-quality piano suitable for all levels.', 4376021.559, 24, 2, 17, 'piano4.jpg', N'Germany', 2022, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Position Piano Model 937', N'This is a high-quality piano suitable for all levels.', 6977098.225, 55, 2, 11, 'piano3.jpg', N'Japan', 2021, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Realize Piano Model 231', N'This is a high-quality piano suitable for all levels.', 12766426.147, 40, 2, 16, 'piano6.jpg', N'Germany', 2018, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Ever Piano Model 392', N'This is a high-quality piano suitable for all levels.', 9541147.959, 30, 2, 15, 'piano8.jpg', N'South Korea', 2022, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Maybe Piano Model 649', N'This is a high-quality piano suitable for all levels.', 9880988.089, 39, 2, 14, 'piano1.jpg', N'USA', 2022, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Authority Piano Model 201', N'This is a high-quality piano suitable for all levels.', 3416066.514, 58, 2, 14, 'piano4.jpg', N'China', 2023, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Behind Piano Model 106', N'This is a high-quality piano suitable for all levels.', 11386901.777, 70, 2, 17, 'piano1.jpg', N'USA', 2021, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Respond Piano Model 379', N'This is a high-quality piano suitable for all levels.', 2655420.375, 99, 2, 20, 'piano6.jpg', N'Japan', 2023, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Sometimes Piano Model 820', N'This is a high-quality piano suitable for all levels.', 8652925.039, 41, 2, 14, 'piano4.jpg', N'USA', 2022, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Case Piano Model 790', N'This is a high-quality piano suitable for all levels.', 5582331.205, 52, 2, 18, 'piano5.jpg', N'South Korea', 2019, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Under Piano Model 929', N'This is a high-quality piano suitable for all levels.', 1216982.661, 69, 2, 16, 'piano6.jpg', N'South Korea', 2023, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Citizen Piano Model 931', N'This is a high-quality piano suitable for all levels.', 2817519.995, 55, 2, 13, 'piano3.jpg', N'South Korea', 2018, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Wind Piano Model 883', N'This is a high-quality piano suitable for all levels.', 3891059.346, 68, 2, 20, 'piano4.jpg', N'Japan', 2023, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'American Piano Model 935', N'This is a high-quality piano suitable for all levels.', 4271654.044, 54, 2, 16, 'piano10.jpg', N'South Korea', 2019, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Thousand Piano Model 610', N'This is a high-quality piano suitable for all levels.', 13611337.951, 18, 2, 20, 'piano1.jpg', N'South Korea', 2022, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Be Piano Model 600', N'This is a high-quality piano suitable for all levels.', 7378440.621, 6, 2, 14, 'piano9.jpg', N'Vietnam', 2019, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Water Piano Model 606', N'This is a high-quality piano suitable for all levels.', 12329312.722, 99, 2, 18, 'piano9.jpg', N'China', 2023, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Scene Piano Model 365', N'This is a high-quality piano suitable for all levels.', 2924219.88, 56, 2, 14, 'piano6.jpg', N'China', 2021, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Wind Piano Model 313', N'This is a high-quality piano suitable for all levels.', 1536030.117, 97, 2, 14, 'piano6.jpg', N'Germany', 2023, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Themselves Piano Model 775', N'This is a high-quality piano suitable for all levels.', 10209637.442, 38, 2, 16, 'piano3.jpg', N'China', 2018, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Now Piano Model 687', N'This is a high-quality piano suitable for all levels.', 8553186.274, 98, 2, 13, 'piano6.jpg', N'USA', 2021, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Result Piano Model 162', N'This is a high-quality piano suitable for all levels.', 1343905.489, 10, 2, 11, 'piano4.jpg', N'Vietnam', 2020, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Include Piano Model 940', N'This is a high-quality piano suitable for all levels.', 1873680.747, 89, 2, 17, 'piano3.jpg', N'Japan', 2021, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Third Piano Model 245', N'This is a high-quality piano suitable for all levels.', 6012491.885, 27, 2, 16, 'piano7.jpg', N'Germany', 2018, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Season Piano Model 370', N'This is a high-quality piano suitable for all levels.', 8471878.137, 99, 2, 18, 'piano1.jpg', N'South Korea', 2018, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Network Piano Model 499', N'This is a high-quality piano suitable for all levels.', 3398418.65, 69, 2, 13, 'piano10.jpg', N'Vietnam', 2022, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Fact Piano Model 816', N'This is a high-quality piano suitable for all levels.', 3074350.41, 47, 2, 14, 'piano3.jpg', N'Japan', 2018, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Nearly Piano Model 860', N'This is a high-quality piano suitable for all levels.', 12027539.49, 92, 2, 19, 'piano3.jpg', N'Vietnam', 2018, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Task Piano Model 985', N'This is a high-quality piano suitable for all levels.', 9370297.562, 84, 2, 18, 'piano3.jpg', N'South Korea', 2022, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Eat Piano Model 358', N'This is a high-quality piano suitable for all levels.', 5763504.366, 99, 2, 17, 'piano1.jpg', N'Vietnam', 2018, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Time Piano Model 191', N'This is a high-quality piano suitable for all levels.', 6017112.42, 90, 2, 13, 'piano8.jpg', N'Japan', 2022, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Dinner Piano Model 266', N'This is a high-quality piano suitable for all levels.', 11296996.016, 56, 2, 16, 'piano5.jpg', N'Germany', 2021, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Want Piano Model 418', N'This is a high-quality piano suitable for all levels.', 8424788.375, 41, 2, 19, 'piano8.jpg', N'USA', 2024, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Respond Piano Model 684', N'This is a high-quality piano suitable for all levels.', 8729336.125, 92, 2, 11, 'piano8.jpg', N'Germany', 2023, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Perform Piano Model 513', N'This is a high-quality piano suitable for all levels.', 5852243.848, 11, 2, 11, 'piano5.jpg', N'Vietnam', 2018, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'That Piano Model 797', N'This is a high-quality piano suitable for all levels.', 10525509.82, 94, 2, 15, 'piano4.jpg', N'South Korea', 2022, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Kind Piano Model 495', N'This is a high-quality piano suitable for all levels.', 14698363.719, 37, 2, 14, 'piano2.jpg', N'South Korea', 2020, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Particularly Piano Model 700', N'This is a high-quality piano suitable for all levels.', 10434094.504, 73, 2, 16, 'piano3.jpg', N'Japan', 2020, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Face Piano Model 939', N'This is a high-quality piano suitable for all levels.', 1127289.773, 11, 2, 20, 'piano3.jpg', N'China', 2020, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Little Piano Model 740', N'This is a high-quality piano suitable for all levels.', 5107939.411, 68, 2, 17, 'piano10.jpg', N'Germany', 2019, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Mind Piano Model 907', N'This is a high-quality piano suitable for all levels.', 2970622.39, 10, 2, 18, 'piano3.jpg', N'China', 2018, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Recent Piano Model 591', N'This is a high-quality piano suitable for all levels.', 13738684.41, 90, 2, 15, 'piano10.jpg', N'Japan', 2018, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Put Piano Model 534', N'This is a high-quality piano suitable for all levels.', 4901900.987, 27, 2, 19, 'piano3.jpg', N'USA', 2023, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'School Piano Model 261', N'This is a high-quality piano suitable for all levels.', 9115617.376, 69, 2, 19, 'piano10.jpg', N'Germany', 2024, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Whom Piano Model 372', N'This is a high-quality piano suitable for all levels.', 5359568.79, 6, 2, 17, 'piano5.jpg', N'China', 2022, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Student Piano Model 667', N'This is a high-quality piano suitable for all levels.', 5451021.536, 48, 2, 14, 'piano7.jpg', N'Japan', 2024, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Heavy Piano Model 868', N'This is a high-quality piano suitable for all levels.', 8158779.101, 89, 2, 20, 'piano7.jpg', N'China', 2021, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Beautiful Piano Model 675', N'This is a high-quality piano suitable for all levels.', 13774007.259, 86, 2, 20, 'piano4.jpg', N'USA', 2020, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Garden Piano Model 262', N'This is a high-quality piano suitable for all levels.', 10523611.476, 85, 2, 16, 'piano8.jpg', N'USA', 2023, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Position Piano Model 355', N'This is a high-quality piano suitable for all levels.', 9001822.922, 35, 2, 15, 'piano3.jpg', N'Germany', 2018, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Business Piano Model 558', N'This is a high-quality piano suitable for all levels.', 4314269.963, 96, 2, 18, 'piano9.jpg', N'Vietnam', 2018, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Message Piano Model 268', N'This is a high-quality piano suitable for all levels.', 7166941.665, 13, 2, 17, 'piano7.jpg', N'China', 2020, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'People Piano Model 875', N'This is a high-quality piano suitable for all levels.', 11828710.101, 83, 2, 16, 'piano2.jpg', N'China', 2018, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Professor Piano Model 111', N'This is a high-quality piano suitable for all levels.', 11675375.577, 30, 2, 17, 'piano7.jpg', N'Germany', 2024, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Government Piano Model 740', N'This is a high-quality piano suitable for all levels.', 10423070.248, 94, 2, 11, 'piano10.jpg', N'Germany', 2020, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Through Piano Model 229', N'This is a high-quality piano suitable for all levels.', 8901814.043, 40, 2, 16, 'piano1.jpg', N'Germany', 2021, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Customer Piano Model 238', N'This is a high-quality piano suitable for all levels.', 1582207.509, 77, 2, 16, 'piano6.jpg', N'USA', 2018, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Eight Piano Model 834', N'This is a high-quality piano suitable for all levels.', 2551349.412, 74, 2, 18, 'piano1.jpg', N'China', 2024, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Admit Piano Model 422', N'This is a high-quality piano suitable for all levels.', 6497080.704, 21, 2, 15, 'piano7.jpg', N'Vietnam', 2019, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Sign Piano Model 251', N'This is a high-quality piano suitable for all levels.', 6658846.23, 44, 2, 19, 'piano1.jpg', N'Japan', 2019, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Experience Piano Model 592', N'This is a high-quality piano suitable for all levels.', 10874382.548, 96, 2, 11, 'piano9.jpg', N'USA', 2024, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'But Piano Model 807', N'This is a high-quality piano suitable for all levels.', 11418069.897, 85, 2, 17, 'piano3.jpg', N'China', 2024, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Season Piano Model 932', N'This is a high-quality piano suitable for all levels.', 2159186.878, 76, 2, 13, 'piano5.jpg', N'Japan', 2024, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Discussion Piano Model 435', N'This is a high-quality piano suitable for all levels.', 10805678.963, 37, 2, 15, 'piano9.jpg', N'Germany', 2019, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Hot Piano Model 665', N'This is a high-quality piano suitable for all levels.', 3139467.676, 85, 2, 20, 'piano3.jpg', N'Vietnam', 2022, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Study Piano Model 875', N'This is a high-quality piano suitable for all levels.', 5425122.853, 14, 2, 14, 'piano8.jpg', N'South Korea', 2019, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Conference Violin Model 634', N'This is a high-quality violin suitable for all levels.', 3231455.937, 47, 3, 23, 'violin8.jpg', N'South Korea', 2018, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Go Violin Model 184', N'This is a high-quality violin suitable for all levels.', 12488319.362, 48, 3, 21, 'violin2.jpg', N'USA', 2021, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Last Violin Model 460', N'This is a high-quality violin suitable for all levels.', 8983838.695, 47, 3, 27, 'violin9.jpg', N'China', 2024, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Team Violin Model 221', N'This is a high-quality violin suitable for all levels.', 2905518.759, 7, 3, 23, 'violin3.jpg', N'USA', 2020, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Assume Violin Model 297', N'This is a high-quality violin suitable for all levels.', 1617953.105, 87, 3, 21, 'violin5.jpg', N'Germany', 2018, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Blood Violin Model 885', N'This is a high-quality violin suitable for all levels.', 12122283.071, 26, 3, 26, 'violin2.jpg', N'Germany', 2018, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Stay Violin Model 463', N'This is a high-quality violin suitable for all levels.', 9457985.629, 84, 3, 25, 'violin5.jpg', N'South Korea', 2024, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Child Violin Model 522', N'This is a high-quality violin suitable for all levels.', 3529327.858, 63, 3, 25, 'violin4.jpg', N'Germany', 2018, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Top Violin Model 198', N'This is a high-quality violin suitable for all levels.', 2727118.763, 49, 3, 21, 'violin3.jpg', N'Germany', 2022, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Save Violin Model 769', N'This is a high-quality violin suitable for all levels.', 13557989.047, 46, 3, 28, 'violin9.jpg', N'Vietnam', 2024, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Discuss Violin Model 607', N'This is a high-quality violin suitable for all levels.', 7671456.107, 11, 3, 29, 'violin7.jpg', N'China', 2018, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Answer Violin Model 628', N'This is a high-quality violin suitable for all levels.', 2340052.662, 15, 3, 26, 'violin6.jpg', N'USA', 2021, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Technology Violin Model 257', N'This is a high-quality violin suitable for all levels.', 13726782.286, 85, 3, 25, 'violin1.jpg', N'USA', 2021, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Painting Violin Model 260', N'This is a high-quality violin suitable for all levels.', 14221796.123, 94, 3, 23, 'violin3.jpg', N'Japan', 2024, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Protect Violin Model 755', N'This is a high-quality violin suitable for all levels.', 10517718.594, 84, 3, 26, 'violin1.jpg', N'Germany', 2023, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Where Violin Model 507', N'This is a high-quality violin suitable for all levels.', 1618359.783, 35, 3, 25, 'violin6.jpg', N'Japan', 2019, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Would Violin Model 331', N'This is a high-quality violin suitable for all levels.', 3290698.903, 58, 3, 28, 'violin6.jpg', N'South Korea', 2019, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Nor Violin Model 678', N'This is a high-quality violin suitable for all levels.', 11790631.758, 25, 3, 30, 'violin1.jpg', N'Vietnam', 2021, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Play Violin Model 920', N'This is a high-quality violin suitable for all levels.', 3407472.074, 24, 3, 21, 'violin1.jpg', N'China', 2022, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Response Violin Model 139', N'This is a high-quality violin suitable for all levels.', 1660874.165, 19, 3, 30, 'violin10.jpg', N'Japan', 2024, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Back Violin Model 789', N'This is a high-quality violin suitable for all levels.', 12015887.702, 8, 3, 27, 'violin7.jpg', N'South Korea', 2023, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Agreement Violin Model 828', N'This is a high-quality violin suitable for all levels.', 4471422.068, 22, 3, 26, 'violin9.jpg', N'Japan', 2022, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Capital Violin Model 174', N'This is a high-quality violin suitable for all levels.', 2817166.758, 77, 3, 26, 'violin2.jpg', N'Germany', 2021, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Prove Violin Model 582', N'This is a high-quality violin suitable for all levels.', 6344630.131, 55, 3, 24, 'violin8.jpg', N'Germany', 2022, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Current Violin Model 955', N'This is a high-quality violin suitable for all levels.', 4533161.953, 40, 3, 29, 'violin6.jpg', N'South Korea', 2018, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Police Violin Model 726', N'This is a high-quality violin suitable for all levels.', 11914326.226, 35, 3, 25, 'violin1.jpg', N'South Korea', 2020, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Then Violin Model 741', N'This is a high-quality violin suitable for all levels.', 2493241.947, 11, 3, 23, 'violin7.jpg', N'USA', 2024, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Parent Violin Model 848', N'This is a high-quality violin suitable for all levels.', 13183231.739, 55, 3, 27, 'violin2.jpg', N'Vietnam', 2021, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Call Violin Model 573', N'This is a high-quality violin suitable for all levels.', 3259306.672, 48, 3, 28, 'violin7.jpg', N'Japan', 2022, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Include Violin Model 880', N'This is a high-quality violin suitable for all levels.', 8049880.472, 52, 3, 26, 'violin3.jpg', N'Vietnam', 2020, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Benefit Violin Model 745', N'This is a high-quality violin suitable for all levels.', 8262041.916, 11, 3, 24, 'violin5.jpg', N'Japan', 2023, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Hospital Violin Model 432', N'This is a high-quality violin suitable for all levels.', 5144596.527, 86, 3, 21, 'violin5.jpg', N'South Korea', 2021, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'These Violin Model 798', N'This is a high-quality violin suitable for all levels.', 6747657.029, 53, 3, 24, 'violin6.jpg', N'Japan', 2019, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Business Violin Model 727', N'This is a high-quality violin suitable for all levels.', 5997491.839, 8, 3, 27, 'violin10.jpg', N'Germany', 2021, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Although Violin Model 757', N'This is a high-quality violin suitable for all levels.', 10950777.724, 92, 3, 22, 'violin7.jpg', N'South Korea', 2023, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Police Violin Model 241', N'This is a high-quality violin suitable for all levels.', 3369262.041, 31, 3, 23, 'violin4.jpg', N'USA', 2022, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Age Violin Model 938', N'This is a high-quality violin suitable for all levels.', 7902589.284, 84, 3, 25, 'violin6.jpg', N'Vietnam', 2018, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Day Violin Model 891', N'This is a high-quality violin suitable for all levels.', 13085054.663, 25, 3, 26, 'violin9.jpg', N'China', 2022, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Crime Violin Model 248', N'This is a high-quality violin suitable for all levels.', 13770342.389, 99, 3, 29, 'violin5.jpg', N'Japan', 2021, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Serious Violin Model 499', N'This is a high-quality violin suitable for all levels.', 14281972.934, 70, 3, 25, 'violin7.jpg', N'Germany', 2024, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Candidate Violin Model 799', N'This is a high-quality violin suitable for all levels.', 14625065.179, 23, 3, 21, 'violin10.jpg', N'South Korea', 2023, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Measure Violin Model 629', N'This is a high-quality violin suitable for all levels.', 2495395.092, 87, 3, 24, 'violin10.jpg', N'Vietnam', 2022, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Develop Violin Model 213', N'This is a high-quality violin suitable for all levels.', 4733509.985, 98, 3, 30, 'violin3.jpg', N'Germany', 2018, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Short Violin Model 110', N'This is a high-quality violin suitable for all levels.', 2615579.147, 51, 3, 28, 'violin6.jpg', N'USA', 2023, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Such Violin Model 477', N'This is a high-quality violin suitable for all levels.', 9179540.588, 37, 3, 28, 'violin4.jpg', N'Japan', 2022, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Ask Violin Model 947', N'This is a high-quality violin suitable for all levels.', 13525479.861, 70, 3, 23, 'violin1.jpg', N'Vietnam', 2024, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Write Violin Model 999', N'This is a high-quality violin suitable for all levels.', 14912291.0, 57, 3, 30, 'violin4.jpg', N'Germany', 2023, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Respond Violin Model 514', N'This is a high-quality violin suitable for all levels.', 4697786.05, 80, 3, 23, 'violin7.jpg', N'Japan', 2021, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Agency Violin Model 154', N'This is a high-quality violin suitable for all levels.', 13827598.477, 16, 3, 30, 'violin7.jpg', N'China', 2019, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Off Violin Model 994', N'This is a high-quality violin suitable for all levels.', 7377347.235, 66, 3, 30, 'violin2.jpg', N'China', 2024, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Large Violin Model 602', N'This is a high-quality violin suitable for all levels.', 8711090.796, 55, 3, 28, 'violin5.jpg', N'Japan', 2019, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Pressure Violin Model 473', N'This is a high-quality violin suitable for all levels.', 3233556.347, 82, 3, 23, 'violin8.jpg', N'USA', 2018, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Blood Violin Model 502', N'This is a high-quality violin suitable for all levels.', 8925683.732, 57, 3, 29, 'violin2.jpg', N'China', 2021, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Thing Violin Model 934', N'This is a high-quality violin suitable for all levels.', 2552224.727, 23, 3, 26, 'violin2.jpg', N'Japan', 2023, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Ever Violin Model 942', N'This is a high-quality violin suitable for all levels.', 10317640.781, 80, 3, 29, 'violin4.jpg', N'USA', 2018, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Available Violin Model 671', N'This is a high-quality violin suitable for all levels.', 10797023.479, 82, 3, 28, 'violin2.jpg', N'Germany', 2022, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Do Violin Model 995', N'This is a high-quality violin suitable for all levels.', 11920342.183, 17, 3, 21, 'violin4.jpg', N'Japan', 2021, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Away Violin Model 381', N'This is a high-quality violin suitable for all levels.', 4144626.067, 68, 3, 26, 'violin9.jpg', N'China', 2018, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Radio Violin Model 412', N'This is a high-quality violin suitable for all levels.', 9031337.067, 33, 3, 26, 'violin7.jpg', N'Japan', 2019, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Fish Violin Model 304', N'This is a high-quality violin suitable for all levels.', 11393432.951, 66, 3, 26, 'violin5.jpg', N'Germany', 2022, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Hard Violin Model 951', N'This is a high-quality violin suitable for all levels.', 11899785.322, 56, 3, 26, 'violin9.jpg', N'Germany', 2019, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Least Violin Model 826', N'This is a high-quality violin suitable for all levels.', 6235138.035, 50, 3, 27, 'violin5.jpg', N'China', 2021, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Couple Violin Model 389', N'This is a high-quality violin suitable for all levels.', 13131205.048, 66, 3, 25, 'violin2.jpg', N'Germany', 2019, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Ask Violin Model 349', N'This is a high-quality violin suitable for all levels.', 11406505.098, 48, 3, 28, 'violin4.jpg', N'USA', 2023, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Most Violin Model 498', N'This is a high-quality violin suitable for all levels.', 7507458.323, 64, 3, 30, 'violin10.jpg', N'Japan', 2023, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Manage Violin Model 614', N'This is a high-quality violin suitable for all levels.', 5356877.765, 34, 3, 26, 'violin9.jpg', N'Vietnam', 2018, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Among Violin Model 583', N'This is a high-quality violin suitable for all levels.', 5440033.447, 34, 3, 27, 'violin1.jpg', N'South Korea', 2024, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Pick Violin Model 516', N'This is a high-quality violin suitable for all levels.', 2308694.763, 30, 3, 26, 'violin3.jpg', N'USA', 2019, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Blood Violin Model 472', N'This is a high-quality violin suitable for all levels.', 1395675.49, 10, 3, 21, 'violin7.jpg', N'South Korea', 2018, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Scene Violin Model 219', N'This is a high-quality violin suitable for all levels.', 12501078.55, 82, 3, 24, 'violin2.jpg', N'Vietnam', 2021, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Include Violin Model 968', N'This is a high-quality violin suitable for all levels.', 1020932.714, 84, 3, 27, 'violin2.jpg', N'South Korea', 2019, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Decision Violin Model 332', N'This is a high-quality violin suitable for all levels.', 13996499.105, 53, 3, 28, 'violin1.jpg', N'Germany', 2019, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Ever Violin Model 883', N'This is a high-quality violin suitable for all levels.', 1576735.769, 39, 3, 21, 'violin10.jpg', N'China', 2023, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Her Violin Model 946', N'This is a high-quality violin suitable for all levels.', 5722556.84, 63, 3, 23, 'violin10.jpg', N'South Korea', 2018, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'West Violin Model 205', N'This is a high-quality violin suitable for all levels.', 11007786.747, 39, 3, 21, 'violin3.jpg', N'South Korea', 2024, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Sign Violin Model 239', N'This is a high-quality violin suitable for all levels.', 6304725.594, 78, 3, 26, 'violin4.jpg', N'Germany', 2022, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Many Violin Model 223', N'This is a high-quality violin suitable for all levels.', 8834374.811, 93, 3, 28, 'violin2.jpg', N'South Korea', 2021, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'This Violin Model 282', N'This is a high-quality violin suitable for all levels.', 7368636.621, 48, 3, 23, 'violin7.jpg', N'China', 2021, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Week Violin Model 678', N'This is a high-quality violin suitable for all levels.', 8076157.381, 34, 3, 28, 'violin4.jpg', N'China', 2021, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Why Violin Model 124', N'This is a high-quality violin suitable for all levels.', 7257980.422, 5, 3, 29, 'violin7.jpg', N'Germany', 2019, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Over Violin Model 346', N'This is a high-quality violin suitable for all levels.', 4545035.606, 65, 3, 23, 'violin4.jpg', N'Germany', 2020, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Condition Violin Model 768', N'This is a high-quality violin suitable for all levels.', 7806595.686, 24, 3, 29, 'violin2.jpg', N'Japan', 2020, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Save Violin Model 746', N'This is a high-quality violin suitable for all levels.', 10424280.507, 12, 3, 23, 'violin6.jpg', N'USA', 2020, N'Plastic');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Remember Violin Model 924', N'This is a high-quality violin suitable for all levels.', 3244971.251, 64, 3, 27, 'violin4.jpg', N'Germany', 2021, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Democrat Violin Model 271', N'This is a high-quality violin suitable for all levels.', 6472512.712, 48, 3, 29, 'violin4.jpg', N'Vietnam', 2020, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Speak Violin Model 631', N'This is a high-quality violin suitable for all levels.', 13923183.438, 96, 3, 30, 'violin10.jpg', N'Germany', 2019, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Article Violin Model 805', N'This is a high-quality violin suitable for all levels.', 9647502.191, 89, 3, 30, 'violin4.jpg', N'South Korea', 2021, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Story Violin Model 348', N'This is a high-quality violin suitable for all levels.', 7828611.617, 82, 3, 26, 'violin9.jpg', N'Vietnam', 2019, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Require Violin Model 144', N'This is a high-quality violin suitable for all levels.', 1871706.485, 36, 3, 28, 'violin10.jpg', N'Japan', 2023, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Cold Violin Model 211', N'This is a high-quality violin suitable for all levels.', 13067291.375, 71, 3, 27, 'violin5.jpg', N'Vietnam', 2020, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Through Violin Model 801', N'This is a high-quality violin suitable for all levels.', 3690046.774, 52, 3, 29, 'violin6.jpg', N'Vietnam', 2021, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Color Violin Model 549', N'This is a high-quality violin suitable for all levels.', 14860337.431, 45, 3, 28, 'violin2.jpg', N'Japan', 2019, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Guess Violin Model 869', N'This is a high-quality violin suitable for all levels.', 3180782.76, 55, 3, 28, 'violin9.jpg', N'Japan', 2020, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Next Violin Model 147', N'This is a high-quality violin suitable for all levels.', 1297893.73, 31, 3, 22, 'violin7.jpg', N'South Korea', 2022, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Enough Violin Model 653', N'This is a high-quality violin suitable for all levels.', 3946550.42, 5, 3, 23, 'violin9.jpg', N'Vietnam', 2021, N'Spruce');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Buy Violin Model 489', N'This is a high-quality violin suitable for all levels.', 8614807.915, 13, 3, 22, 'violin10.jpg', N'Vietnam', 2021, N'Mahogany');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Picture Violin Model 308', N'This is a high-quality violin suitable for all levels.', 6870808.04, 51, 3, 25, 'violin2.jpg', N'Vietnam', 2018, N'Maple');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Will Violin Model 728', N'This is a high-quality violin suitable for all levels.', 14551614.807, 8, 3, 30, 'violin9.jpg', N'China', 2019, N'Rosewood');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Letter Violin Model 364', N'This is a high-quality violin suitable for all levels.', 2542596.909, 62, 3, 25, 'violin4.jpg', N'Germany', 2021, N'Composite');
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, origin_country, manufacturing_year, material)
VALUES (N'Reduce Violin Model 618', N'This is a high-quality violin suitable for all levels.', 13983604.839, 34, 3, 30, 'violin5.jpg', N'USA', 2018, N'Maple');

-- Product Image
INSERT INTO ProductImages (product_id, image_url, caption, is_primary)
VALUES 
(1, 'guitar1.jpg', 'Front view of guitar', 1),
(1, 'guitar1-side.jpg', 'Side view of guitar', 0),
(2, 'piano1.jpg', 'Piano with bench', 1);

-- Review
INSERT INTO Reviews (product_id, user_id, rating, comment)
VALUES
(1, 2, 5, N'Rất hài lòng với chất lượng sản phẩm'),
(2, 2, 4, N'Sản phẩm tốt nhưng giao hàng hơi chậm');
