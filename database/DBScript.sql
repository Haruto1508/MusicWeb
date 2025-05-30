-- Tạo database nếu chưa tồn tại
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'MusicShop')
BEGIN
    CREATE DATABASE MusicShop;
END
GO

USE MusicShop;
GO

CREATE TABLE Roles (
    role_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(50) UNIQUE NOT NULL,
    description NVARCHAR(255)
);
GO

-- USERS TABLE
CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    full_name NVARCHAR(100),
    email NVARCHAR(100) UNIQUE,
    password NVARCHAR(255),
    phone NVARCHAR(20),
    address NVARCHAR(MAX),
    role_id INT,
    created_at DATETIME DEFAULT GETDATE()
	FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);
GO

-- CATEGORIES TABLE
CREATE TABLE Categories (
    category_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) UNIQUE,
    description NVARCHAR(MAX)
);
GO

-- SUB CATEGORIES TABLE
CREATE TABLE Subcategories (
    subcategory_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) 
);
GO

-- PRODUCTS TABLE
CREATE TABLE Products (
    product_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(150),
    description NVARCHAR(MAX),
    price DECIMAL(15,3),
    stock_quantity INT CHECK (stock_quantity >= 0),
    category_id INT,
    image_url NVARCHAR(MAX),
    discount_type NVARCHAR(20) CHECK (discount_type IN ('percentage', 'fixed')),
    discount_value DECIMAL(15,3) DEFAULT 0 CHECK (discount_value >= 0),
    discount_start DATE,
    discount_end DATE,
    created_at DATETIME DEFAULT GETDATE(),
	sold_quantity INT DEFAULT 0,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);
GO

-- ORDERS TABLE
CREATE TABLE Orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    order_date DATETIME DEFAULT GETDATE(),
    status NVARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'processing', 'shipped', 'delivered', 'cancelled')),
    total_amount DECIMAL(15,3),
    shipping_address NVARCHAR(MAX),
    discount_id INT NULL,
    discount_amount DECIMAL(15,3) DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

-- ORDER DETAILS TABLE
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(15,3),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
GO

-- CART TABLE
CREATE TABLE Cart (
    cart_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    product_id INT,
    quantity INT,
    added_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
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
    amount DECIMAL(15,3),
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

-- DISCOUNTS TABLE (for orders)
CREATE TABLE Discounts (
    discount_id INT PRIMARY KEY IDENTITY(1,1),
    code NVARCHAR(50) UNIQUE NOT NULL,
    description NVARCHAR(MAX),
    discount_type NVARCHAR(20) CHECK (discount_type IN ('percentage', 'fixed')),
    discount_value DECIMAL(15,3) CHECK (discount_value >= 0),
    start_date DATE,
    end_date DATE,
    minimum_order_value DECIMAL(15,3),
    usage_limit INT DEFAULT NULL,
    used_count INT DEFAULT 0,
    is_active BIT DEFAULT 1
);
GO

-- DISCOUNT USERS TABLE (optional, track usage)
CREATE TABLE DiscountUsers (
    id INT PRIMARY KEY IDENTITY(1,1),
    discount_id INT,
    user_id INT,
    used_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (discount_id) REFERENCES Discounts(discount_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

-- WISHLIST TABLE
CREATE TABLE Wishlist (
    wishlist_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    product_id INT,
    added_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- INSERT
INSERT INTO Categories (name, description)
VALUES 
('Guitar', 'Các loại đàn Guitar'),
('Piano', 'Các loại đàn Piano'),
('Violin', 'Các loại đàn Violin');

INSERT INTO Roles (name, description)
VALUES 
('Admin', 'Quản trị viên'),
('Customer', 'Khách hàng');

INSERT INTO Users (full_name, email, password, phone, address, role_id)
VALUES 
('Nguyễn Văn A', 'a@example.com', 'password123', '0901234567', 'Hà Nội', 2),
('Trần Thị B', 'b@example.com', '123456', '0912345678', 'TP.HCM', 1);


-- Guitars (category_id = 1)
INSERT INTO Products (name, description, price, stock_quantity, category_id, image_url, discount_type, discount_value, discount_start, discount_end)
VALUES
('Guitar Classic Yamaha C40', 'Đàn guitar cổ điển phổ biến cho người mới bắt đầu', 2500000, 10, 1, 'img/guitar1.jpg', 'percentage', 10, '2025-05-01', '2025-06-01'),
('Guitar Acoustic Taylor GS Mini', 'Đàn cao cấp với chất lượng âm thanh tuyệt vời', 14500000, 5, 1, 'img/guitar2.jpg', 'fixed', 500000, '2025-05-15', '2025-06-15');

-- Pianos (category_id = 2)
INSERT INTO Products (name, description, price, stock_quantity, category_id, image_url, discount_type, discount_value, discount_start, discount_end)
VALUES
('Piano Điện Yamaha P45', 'Đàn piano điện phù hợp cho người học và biểu diễn tại nhà', 11000000, 7, 2, 'img/piano1.jpg', 'percentage', 5, '2025-05-01', '2025-06-01');

-- Violins (category_id = 3)
INSERT INTO Products (name, description, price, stock_quantity, category_id, image_url, discount_type, discount_value, discount_start, discount_end)
VALUES
('Violin Yamaha V3SKA', 'Violin kích thước 4/4 dành cho người mới', 5500000, 15, 3, 'img/violin1.jpg', 'fixed', 200000, '2025-05-10', '2025-06-10');

INSERT INTO Reviews (product_id, user_id, rating, comment)
VALUES
(1, 1, 5, 'Đàn rất dễ chơi và phù hợp cho người mới bắt đầu!'),
(2, 2, 4, 'Âm thanh tốt nhưng giá hơi cao.');

-- Đơn hàng
INSERT INTO Orders (user_id, total_amount, shipping_address)
VALUES (1, 2500000, '123 Đường ABC, Hà Nội');

-- Chi tiết đơn hàng
INSERT INTO OrderDetails (order_id, product_id, quantity, price)
VALUES (1, 1, 1, 2500000);

INSERT INTO Cart (user_id, product_id, quantity)
VALUES
(1, 2, 1),
(1, 3, 1);

INSERT INTO Wishlist (user_id, product_id)
VALUES
(1, 1),
(1, 3);
