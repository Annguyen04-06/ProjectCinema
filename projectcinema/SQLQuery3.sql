--CREATE SCHEMA RoomManagement AUTHORIZATION dbo;
--GO

-- Tạo bảng Room_A1 trong schema RoomManagement
--CREATE TABLE RoomManagement.Room_A1 (
--    BookingID INT PRIMARY KEY IDENTITY(1,1),
--    ChairName NVARCHAR(50),
--    UserID INT,
--    Username NVARCHAR(50),
--    BookingTime DATETIME DEFAULT GETDATE(),
--    CONSTRAINT FK_User FOREIGN KEY (UserID) REFERENCES Users(UserID) -- Định nghĩa khóa ngoại đúng cách
--);
--Bảng phòng A1 (phim Elemental)
CREATE TABLE RoomManagement.Room_A1 (
    BookingID INT PRIMARY KEY IDENTITY(1,1),
    ChairName NVARCHAR(50),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    Username NVARCHAR(50),
    BookingTime DATETIME DEFAULT GETDATE()
);
--Bảng phòng A2 (phim Encanto)
CREATE TABLE RoomManagement.Room_A2 (
    BookingID INT PRIMARY KEY IDENTITY(1,1),
    ChairName NVARCHAR(50),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    Username NVARCHAR(50),
    BookingTime DATETIME DEFAULT GETDATE()
);
