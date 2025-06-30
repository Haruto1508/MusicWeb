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
    role_id INT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    gender NVARCHAR(12),
    birthdate DATE,
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
    is_default BIT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
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
    discount_type NVARCHAR(20) CHECK (discount_type IN ('percentage', 'fixed')),
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
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
GO

-- ORDERS TABLE
CREATE TABLE Orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    order_date DATETIME DEFAULT GETDATE(),
    status NVARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'processing', 'shipped', 'delivered', 'cancelled')),
    total_amount DECIMAL(15,3) NOT NULL,
    discount_id INT,
	order_phone NVARCHAR(20),
	receiver_name NVARCHAR(255),
    discount_amount DECIMAL(15,3) DEFAULT 0,
	address_id INT,
	FOREIGN KEY (address_id) REFERENCES Address(address_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (discount_id) REFERENCES Discounts(discount_id)
);
GO

-- ORDER DETAILS TABLE
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(15,3) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
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
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
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
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

-- PAYMENTS TABLE
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    payment_date DATETIME DEFAULT GETDATE(),
    amount DECIMAL(15,3) NOT NULL,
    payment_method NVARCHAR(20) CHECK (payment_method IN ('credit_card', 'paypal', 'bank_transfer', 'cod')),
    status NVARCHAR(10) DEFAULT 'unpaid' CHECK (status IN ('paid', 'unpaid', 'failed')),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
GO

-- SHIPPING TABLE
CREATE TABLE Shipping (
    shipping_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    shipping_method NVARCHAR(100),
    tracking_number NVARCHAR(100),
    shipped_date DATETIME,
    estimated_delivery DATETIME,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
GO

-- DISCOUNT USERS TABLE
CREATE TABLE DiscountUsers (
    id INT PRIMARY KEY IDENTITY(1,1),
    discount_id INT,
    user_id INT,
    used_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (discount_id) REFERENCES Discounts(discount_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

-- CREATE INDEXES for performance
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

-- INSERT DATA

-- Insert Roles
INSERT INTO Roles (name, description)
VALUES 
('Admin', 'Quản trị viên'),
('Customer', 'Khách hàng');
GO

-- Insert Users
INSERT INTO Users (full_name, email, password, phone, account)
VALUES ('ram','ram@gmail.com','ed218e06b885297d0750b65be5e4041e','0936541245','ramcute')
GO

-- Insert Categories
INSERT INTO Categories (name, description)
VALUES 
('Guitar', 'Các loại đàn Guitar'),
('Piano', 'Các loại đàn Piano'),
('Violin', 'Các loại đàn Violin');
GO
 -- Insert Brands
INSERT INTO Brands (brand_name)
VALUES 
('Yamaha'),
('Fender'),
('Gibson'),
('Casio'),
('Roland');
GO

-- Insert Discounts
INSERT INTO Discounts (code, description, discount_type, discount_value, start_date, end_date, minimum_order_value, usage_limit)
VALUES
('DISC10', 'Giảm 10% cho đơn hàng đầu tiên', 'percentage', 10, '2025-01-01', '2025-12-31', 100000, 100),
('FIX50', 'Giảm 50k cho đơn hàng trên 500k', 'fixed', 50000, '2025-06-01', '2025-12-31', 500000, 200);
GO

-- Insert Subcategories
INSERT INTO Subcategories (name, category_id)
VALUES
('Electric Guitar', (SELECT category_id FROM Categories WHERE name = 'Guitar')),
('Acoustic Guitar', (SELECT category_id FROM Categories WHERE name = 'Guitar')),
('Grand Piano', (SELECT category_id FROM Categories WHERE name = 'Piano')),
('Upright Piano', (SELECT category_id FROM Categories WHERE name = 'Piano')),
('Classical Violin', (SELECT category_id FROM Categories WHERE name = 'Violin'));
GO

-- Insert Products
INSERT INTO Products (discount_id, name, description, price, stock_quantity, category_id, brand_id, image_url)
VALUES
(NULL, 'Yamaha Acoustic Guitar FG800', 'Đàn Guitar Acoustic Yamaha FG800 chất lượng cao.', 5000000, 10, (SELECT category_id FROM Categories WHERE name = 'Guitar'), (SELECT brand_id FROM Brands WHERE brand_name = 'Yamaha'), 'yamaha_fg800.png'),
(1, 'Fender Stratocaster Electric Guitar', 'Đàn Guitar điện Fender Stratocaster.', 15000000, 5, (SELECT category_id FROM Categories WHERE name = 'Guitar'), (SELECT brand_id FROM Brands WHERE brand_name = 'Fender'), 'fender_stratocaster.png'),
(NULL, 'Casio Digital Piano', 'Đàn Piano điện Casio với nhiều tính năng.', 8000000, 8, (SELECT category_id FROM Categories WHERE name = 'Piano'), (SELECT brand_id FROM Brands WHERE brand_name = 'Casio'), 'casio_dp.png');
GO

-- Insert Product Images
INSERT INTO ProductImages (product_id, image_url, caption, is_primary)
VALUES
((SELECT product_id FROM Products WHERE name = 'Yamaha Acoustic Guitar FG800'), 'yamaha_fg800_1.png', 'Hình chính', 1),
((SELECT product_id FROM Products WHERE name = 'Fender Stratocaster Electric Guitar'), 'fender_strat_1.png', 'Hình chính', 1),
((SELECT product_id FROM Products WHERE name = 'Casio Digital Piano'), 'casio_dp_1.png', 'Hình chính', 1);
GO

-- Insert Orders
INSERT INTO Orders (user_id, total_amount, order_phone, receiver_name, address_id)
VALUES
(1, 15000000, '0936541245', 'Nguyễn Văn Ram', NULL); -- Địa chỉ chưa có, để NULL tạm
GO

-- Insert Order Details
INSERT INTO OrderDetails (order_id, product_id, quantity, price)
VALUES
((SELECT TOP 1 order_id FROM Orders ORDER BY order_id DESC), (SELECT product_id FROM Products WHERE name = 'Fender Stratocaster Electric Guitar'), 1, 15000000);
GO

-- Insert Carts
INSERT INTO Carts (user_id, product_id, quantity)
VALUES
(1, (SELECT product_id FROM Products WHERE name = 'Yamaha Acoustic Guitar FG800'), 1);
GO

-- Insert Reviews
INSERT INTO Reviews (product_id, user_id, rating, comment)
VALUES
((SELECT product_id FROM Products WHERE name = 'Yamaha Acoustic Guitar FG800'), 1, 5, 'Đàn rất tốt, âm thanh tuyệt vời!'),
((SELECT product_id FROM Products WHERE name = 'Fender Stratocaster Electric Guitar'), 1, 4, 'Đàn đẹp nhưng giá hơi cao.');
GO

-- Insert Payments
INSERT INTO Payments (order_id, amount, payment_method, status)
VALUES
((SELECT TOP 1 order_id FROM Orders ORDER BY order_id DESC), 15000000, 'credit_card', 'paid');
GO

-- Insert Shipping
INSERT INTO Shipping (order_id, shipping_method, tracking_number, shipped_date, estimated_delivery)
VALUES
((SELECT TOP 1 order_id FROM Orders ORDER BY order_id DESC), 'Giao hàng nhanh', 'TRK123456789', GETDATE(), DATEADD(day, 5, GETDATE()));
GO

-- Insert DiscountUsers (the usage of discounts by users)
INSERT INTO DiscountUsers (discount_id, user_id)
VALUES
((SELECT discount_id FROM Discounts WHERE code = 'DISC10'), 1);
GO