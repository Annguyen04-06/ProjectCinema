USE CINEMA_Project;
GO

-- 1. Bảng Users (Nhân viên, người dùng và admin)
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    Role NVARCHAR(20) NOT NULL CHECK (Role IN ('Admin', 'Employee', 'User'))
);

-- Dữ liệu mẫu cho Users
INSERT INTO Users (Username, Password, Role)
VALUES 
('admin1', '123', 'Admin'),
('employee1', '123', 'Employee'),
('user1', '123', 'User');

-- 2. Bảng Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID) ON DELETE CASCADE,
    Position NVARCHAR(50),
    Salary DECIMAL(15,2),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Dữ liệu mẫu cho Employees
INSERT INTO Employees (UserID, Position, Salary)
VALUES 
(2, 'Person_1', 5000000),
(2, 'Person_2', 6000000);

-- 3. Bảng Movies (danh sách phim)
CREATE TABLE Movies (
    MovieID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(100) NOT NULL,
    Genre NVARCHAR(50),
    Duration INT,  
    Rating NVARCHAR(10),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Dữ liệu mẫu cho Movies (theo Rating)
INSERT INTO Movies (Title, Genre, Duration, Rating)
VALUES 
('Elemental', 'Animation, Adventure, Comedy', 101, 'G'),
('Encanto', 'Animation, Musical, Adventure', 102, 'G'),
('Puss in Boots: The Last Wish', 'Animation, Adventure, Comedy', 102, 'PG'),
('The Super Mario Bros. Movie', 'Animation, Adventure', 92, 'PG'),
('The Marvels', 'Action, Sci-Fi', 105, 'PG-13'),
('Dune: Part Two', 'Adventure, Sci-Fi', 120, 'PG-13'),
('Oppenheimer', 'Drama, History', 180, 'R'),
('John Wick: Chapter 4', 'Action, Crime', 169, 'R'),
('Blonde', 'Drama, Biography', 166, 'NC-17'),
('Pleasure', 'Drama', 109, 'NC-17');

-- 4. Bảng Showtimes (Lịch chiếu phim)
CREATE TABLE Showtimes (
    ShowtimeID INT PRIMARY KEY IDENTITY(1,1),
    MovieID INT FOREIGN KEY REFERENCES Movies(MovieID) ON DELETE CASCADE,
    Showtime DATETIME NOT NULL,
    ScreenNumber INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Dữ liệu mẫu cho Showtimes
INSERT INTO Showtimes (MovieID, Showtime, ScreenNumber, Price)
VALUES 
(1, '2024-01-10 15:00:00', 1, 220000),
(2, '2024-01-12 18:00:00', 2, 180000),
(3, '2024-01-15 20:00:00', 3, 200000);

-- 5. Bảng Tickets (Quản lý vé)
CREATE TABLE Tickets (
    TicketID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID) ON DELETE CASCADE,
    ShowtimeID INT FOREIGN KEY REFERENCES Showtimes(ShowtimeID) ON DELETE CASCADE,
    SeatNumber NVARCHAR(10) NOT NULL,
    Ticket NVARCHAR(50) NOT NULL,
    TotalPrice DECIMAL(10,2) NOT NULL,
    PurchasedAt DATETIME DEFAULT GETDATE()
);

-- Dữ liệu mẫu cho Tickets
INSERT INTO Tickets (UserID, ShowtimeID, SeatNumber, Ticket, TotalPrice)
VALUES 
(3, 1, 'A1', 'Adult', 150000),
(3, 2, 'B2', 'Adult', 180000),
(3, 3, 'C3', 'Adult', 200000);
-- 6. Bảng Products (Đồ ăn và nước uống)
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL,
    ProductType NVARCHAR(50) NOT NULL CHECK (ProductType IN ('Popcorn', 'Drink')),
    Price DECIMAL(10,2) NOT NULL
);

-- Dữ liệu mẫu cho Products
INSERT INTO Products (ProductName, ProductType, Price)
VALUES 
('Large Popcorn', 'Popcorn', 50000),
('Coke', 'Drink', 30000),
('Sprite', 'Drink', 30000);

-- 7. Bảng Payments (Quản lý thanh toán)
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    TicketID INT FOREIGN KEY REFERENCES Tickets(TicketID) ON DELETE CASCADE,
    PaymentMethod NVARCHAR(50) NOT NULL CHECK (PaymentMethod IN ('Cash', 'Card', 'E-Wallet')),
    PaymentDate DATETIME DEFAULT GETDATE(),
    AmountPaid DECIMAL(10,2) NOT NULL
);

-- Dữ liệu mẫu cho Payments
INSERT INTO Payments (TicketID, PaymentMethod, AmountPaid)
VALUES 
(1, 'Cash', 350000),
(2, 'Card', 1280000),
(3, 'E-Wallet', 200000);

-- 8. Bảng ChairBookings (Lưu thông tin đặt chỗ)
CREATE TABLE ChairBookings (
    BookingID INT PRIMARY KEY IDENTITY(1,1),
    ChairName NVARCHAR(50),
    UserID INT FOREIGN KEY REFERENCES Users(UserID) ON DELETE CASCADE,
    Username NVARCHAR(50),
    BookingTime DATETIME DEFAULT GETDATE()
);

CREATE TABLE Staff (
    StaffID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    DOB DATE NOT NULL,
    Age INT CHECK (Age > 0),
    Gender NVARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
    Hometown NVARCHAR(100),
    Position NVARCHAR(50),
    CreatedAt DATETIME DEFAULT GETDATE()
);

INSERT INTO Staff (Name, DOB, Age, Gender, Hometown, Position)
VALUES 
('Vo Van A', '1990-05-15', 34, 'Male', 'Hanoi', 'Manager'),
('Tran Thi B', '1995-10-22', 29, 'Female', 'Ho Chi Minh', 'Cashier'),
('Le Hoang C', '1988-07-07', 36, 'Male', 'Da Nang', 'Security'),
('Pham Duy D', '1993-03-25', 31, 'Male', 'Can Tho', 'Technician'),
('Hoang My E', '2000-12-12', 24, 'Female', 'Hue', 'Ticket Seller');

-- Dữ liệu mẫu cho ChairBookings
--INSERT INTO ChairBookings (ChairName, UserID, Username)
--VALUES 
--('Chair 1', 1, 'Person 1'),
--('Chair 2', 2, 'Person 2'),
--('Chair 3', 3, 'Person 3');

-- ✅ Truy vấn kiểm tra tất cả dữ liệu
--SELECT * FROM Users;
--SELECT * FROM Employees;
--SELECT * FROM Movies;
--SELECT * FROM Showtimes;
--SELECT * FROM Tickets;
--SELECT * FROM Products;
--SELECT * FROM Payments;
--SELECT * FROM ChairBookings;