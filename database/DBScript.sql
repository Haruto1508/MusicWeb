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
    gender INT DEFAULT NULL,
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
    FOREIGN KEY (address_id) REFERENCES Address(address_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
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

-- PAYMENTS TABLE
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    payment_date DATETIME DEFAULT GETDATE(),
    amount DECIMAL(15,3) NOT NULL,
    payment_method INT DEFAULT 2 CHECK (payment_method IN (1, 2)), -- 1 credit card, 2 money
    status INT DEFAULT 2 CHECK (status IN (1, 2, 3)),
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

-- INSERT DATA

INSERT INTO Roles (name, description)
VALUES 
('Admin', 'Administrator with full access'),
('Customer', 'Regular customer user');

-- USERS
INSERT INTO Users (full_name, email, password, phone, role_id, gender, birthdate, account)
VALUES 
('Admin User', 'admin@example.com', 'admin123', '1234567890', 1, 1, '1985-01-01', 'adminuser'),
('Rem', 'rem@gmail.com', '93a6be90e81a902c15ab3103e2990ecb', '0987654321', 2, 1, '1995-06-15', 'remcute');  -- user_id = 2

-- CATEGORIES
INSERT INTO Categories (name, description)
VALUES 
('Guitars', 'All kinds of guitars'),
('Keyboards', 'Digital and analog keyboards');

-- SUBCATEGORIES
INSERT INTO Subcategories (name, category_id)
VALUES 
('Electric Guitars', 1),
('Acoustic Guitars', 1),
('Digital Keyboards', 2);

-- BRANDS
INSERT INTO Brands (brand_name)
VALUES 
('Yamaha'),
('Fender'),
('Roland');

-- DISCOUNTS
INSERT INTO Discounts (code, description, discount_type, discount_value, start_date, end_date, minimum_order_value, usage_limit)
VALUES 
('SUMMER10', '10% off for summer sale', 1, 10.0, '2025-06-01', '2025-08-01', 100.0, 100),
('FIXED5', 'Flat 5$ discount', 2, 5.0, '2025-07-01', '2025-12-31', 50.0, 50);

-- PRODUCTS
INSERT INTO Products (discount_id, name, description, price, stock_quantity, category_id, brand_id, image_url)
VALUES
(1, 'Fender Stratocaster', 'Electric guitar from Fender', 499.99, 10, 1, 2, 'fender_strat.jpg'),
(NULL, 'Yamaha Acoustic F310', 'Popular beginner acoustic guitar', 199.99, 25, 1, 1, 'yamaha_f310.jpg'),
(2, 'Roland GO:KEYS', '61-key portable keyboard', 299.99, 15, 2, 3, 'roland_gokeys.jpg');

-- ADDRESS for user_id = 2
INSERT INTO Address (user_id, street, ward, district, city, type, is_default, receiver_name, receiver_phone)
VALUES 
(2, '123 Main St', 'Ward 5', 'District 1', 'Ho Chi Minh', 'Home', 1, 'John Doe', '0987654321');

-- CART for user_id = 2
INSERT INTO Carts (user_id, product_id, quantity)
VALUES 
(2, 1, 1),
(2, 3, 2);

-- ORDER for user_id = 2
INSERT INTO Orders (user_id, order_date, status, total_amount, discount_id, discount_amount, address_id)
VALUES 
(2, GETDATE(), 2, 749.97, 2, 5.0, 1);  -- Order with 2 products, 1 discount

-- ORDER DETAILS (assuming order_id = 1)
INSERT INTO OrderDetails (order_id, product_id, quantity, price)
VALUES 
(1, 1, 1, 499.99),
(1, 3, 1, 299.99);

-- PAYMENTS
INSERT INTO Payments (order_id, amount, payment_method, status)
VALUES 
(1, 744.97, 2, 1); -- COD, paid

-- SHIPPING
INSERT INTO Shipping (order_id, shipping_method, tracking_number, shipped_date, estimated_delivery)
VALUES 
(1, 'Standard Shipping', 'VN123456789', GETDATE(), DATEADD(DAY, 5, GETDATE()));

-- REVIEWS by user_id = 2
INSERT INTO Reviews (product_id, user_id, rating, comment)
VALUES 
(1, 2, 5, 'Amazing sound and quality!'),
(3, 2, 4, 'Very portable and user-friendly.');

-----------------------------
INSERT INTO Orders (user_id, order_date, status, total_amount, discount_id, discount_amount, address_id)
VALUES (2, '2025-06-20', 3, 499.99, NULL, 0, 1);  -- Đã giao

INSERT INTO OrderDetails (order_id, product_id, quantity, price)
VALUES (2, 1, 1, 499.99);

INSERT INTO Payments (order_id, amount, payment_method, status)
VALUES (2, 499.99, 1, 1); -- bank_transfer, paid

INSERT INTO Shipping (order_id, shipping_method, tracking_number, shipped_date, estimated_delivery)
VALUES (2, 'Express', 'EXP20250620', '2025-06-21', '2025-06-23');

-- Đơn hàng 3
INSERT INTO Orders (user_id, order_date, status, total_amount, discount_id, discount_amount, address_id)
VALUES (2, '2025-07-01', 1, 199.99, NULL, 0, 1);  -- Đang chờ xử lý

INSERT INTO OrderDetails (order_id, product_id, quantity, price)
VALUES (3, 2, 1, 199.99);

INSERT INTO Payments (order_id, amount, payment_method, status)
VALUES (3, 199.99, 2, 2); -- COD, unpaid

-- Đơn hàng 4
INSERT INTO Orders (user_id, order_date, status, total_amount, discount_id, discount_amount, address_id)
VALUES (2, '2025-06-15', 5, 299.99, NULL, 0, 1);  -- Đã huỷ

INSERT INTO OrderDetails (order_id, product_id, quantity, price)
VALUES (4, 3, 1, 299.99);

INSERT INTO Payments (order_id, amount, payment_method, status)
VALUES (4, 299.99, 2, 3); -- COD, failed

-- Đơn hàng 5
INSERT INTO Orders (user_id, order_date, status, total_amount, discount_id, discount_amount, address_id)
VALUES (2, '2025-06-10', 4, 999.98, 1, 10.0, 1); -- Đã giao

INSERT INTO OrderDetails (order_id, product_id, quantity, price)
VALUES 
(5, 1, 1, 499.99),
(5, 3, 1, 299.99);

INSERT INTO Payments (order_id, amount, payment_method, status)
VALUES (5, 989.98, 1, 1); -- bank_transfer, paid

INSERT INTO Shipping (order_id, shipping_method, tracking_number, shipped_date, estimated_delivery)
VALUES (5, 'Standard Shipping', 'STD20250610', '2025-06-11', '2025-06-16');