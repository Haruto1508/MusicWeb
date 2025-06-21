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
    user_id INT,
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

CREATE TABLE 

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
    shipping_address NVARCHAR(MAX) NOT NULL,
    shipping_phone NVARCHAR(20),
    discount_id INT,
    discount_amount DECIMAL(15,3) DEFAULT 0,
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

-- Insert Subcategories
INSERT INTO Subcategories (name, category_id)
VALUES 
('Guitar Classic', 1),
('Guitar Acoustic', 1),
('Piano Điện', 2),
('Violin 4/4', 3);
GO

-- Insert Brands
INSERT INTO Brands (brand_name)
VALUES 
('Yamaha'),
('Taylor');
GO

-- Insert Discounts
INSERT INTO Discounts (code, description, discount_type, discount_value, start_date, end_date, is_active)
VALUES 
('DISCOUNT10', 'Giảm giá 10% cho Guitar', 'percentage', 10, '2025-06-01', '2025-06-30', 1),
('FIXED500', 'Giảm giá 500k cho Guitar', 'fixed', 500000, '2025-06-01', '2025-06-30', 1),
('DISCOUNT5', 'Giảm giá 5% cho Piano', 'percentage', 5, '2025-06-01', '2025-06-30', 1),
('FIXED200', 'Giảm giá 200k cho Violin', 'fixed', 200000, '2025-06-01', '2025-06-30', 1);
GO

-- Insert Products
INSERT INTO Products (name, description, price, stock_quantity, category_id, brand_id, image_url, discount_id)
VALUES
('Guitar Classic Yamaha C40', N'Đàn guitar cổ điển phổ biến cho người mới bắt đầu', 2500000, 10, 1, 1, 'img/guitar1.jpg', 1),
('Guitar Acoustic Taylor GS Mini', N'Đàn cao cấp với chất lượng âm thanh tuyệt vời', 14500000, 5, 1, 2, 'img/guitar2.jpg', 2),
('Piano Điện Yamaha P45', N'Đàn piano điện phù hợp cho người học và biểu diễn tại nhà', 11000000, 7, 2, 1, 'img/piano1.jpg', 3),
('Violin Yamaha V3SKA', N'Violin kích thước 4/4 dành cho người mới', 5500000, 15, 3, 1, 'img/violin1.jpg', 4);
GO

-- Insert ProductImages
INSERT INTO ProductImages (product_id, image_url, caption, is_primary)
VALUES
(1, 'img/guitar1.jpg', N'Hình ảnh chính của Guitar Yamaha C40', 1),
(1, 'img/guitar1_side.jpg', N'Hình ảnh bên hông của Guitar Yamaha C40', 0),
(1, 'img/guitar1_detail.jpg', N'Hình ảnh chi tiết của Guitar Yamaha C40', 0),
(2, 'img/guitar2.jpg', N'Hình ảnh chính của Guitar Taylor GS Mini', 1),
(2, 'img/guitar2_back.jpg', N'Hình ảnh mặt sau của Guitar Taylor GS Mini', 0),
(3, 'img/piano1.jpg', N'Hình ảnh chính của Piano Yamaha P45', 1),
(4, 'img/violin1.jpg', N'Hình ảnh chính của Violin Yamaha V3SKA', 1),
(4, 'img/violin1_closeup.jpg', N'Hình ảnh cận cảnh của Violin Yamaha V3SKA', 0);
GO

-- Insert Address
INSERT INTO Address (user_id, type, street, ward, district, city, is_default)
VALUES 
(1, N'Nhà riêng', N'12A Hòa Bình', N'Phường Hiệp Tân', N'Quận Tân Phú', N'TP. HCM', 1),
(1, N'Văn phòng', N'123 Nguyễn Huệ', N'Phường Bến Nghé', N'Quận 1', N'TP. HCM', 1),
(1, N'Nhà riêng', N'456 Lê Lợi', N'Phường 1', N'Quận 3', N'TP. HCM', 1),
(1, N'Nhà riêng', N'789 Mậu Thân', N'Phường 3', N'Vĩnh Long', N'Vĩnh Long', 1);
GO

-- Insert Reviews
INSERT INTO Reviews (product_id, user_id, rating, comment)
VALUES
(1, 1, 5, N'Đàn rất dễ chơi và phù hợp cho người mới bắt đầu!'),
(2, 1, 4, N'Âm thanh tốt nhưng giá hơi cao.');
GO

-- Insert Orders
INSERT INTO Orders (user_id, order_date, total_amount, shipping_address, shipping_phone, discount_id, discount_amount)
VALUES 
(1, '2025-06-17', 2250000, N'123 Đường ABC, Hà Nội', '0901234567', 1, 250000),
(1, '2025-06-17', 2500000, N'789 Mậu Thân, Vĩnh Long', '0934567890', NULL, 0),
(1, '2025-06-17', 3500000, N'789 Mậu Thân, Vĩnh Long', '0934567890', NULL, 0);
GO

-- Insert OrderDetails
INSERT INTO OrderDetails (order_id, product_id, quantity, price)
VALUES 
(1, 1, 1, 2250000),
(2, 1, 1, 2500000),
(3, 3, 1, 3500000);
GO

-- Insert Carts
INSERT INTO Carts (user_id, product_id, quantity)
VALUES
(1, 2, 1),
(1, 3, 1),
(1, 1, 2),
(1, 4, 2);
GO

-- Insert Payments
INSERT INTO Payments (order_id, amount, payment_method, status)
VALUES 
(1, 2250000, 'credit_card', 'paid'),
(2, 2500000, 'cod', 'unpaid');
GO

-- Insert Shipping
INSERT INTO Shipping (order_id, shipping_method, tracking_number, shipped_date, estimated_delivery)
VALUES 
(1, N'Giao hàng nhanh', 'GHN123456', '2025-06-18', '2025-06-20'),
(2, N'Giao hàng tiết kiệm', 'GHTK789012', '2025-06-19', '2025-06-22');
GO

-- Insert DiscountUsers
INSERT INTO DiscountUsers (discount_id, user_id)
VALUES 
(1, 1),
(2, 1);
GO
