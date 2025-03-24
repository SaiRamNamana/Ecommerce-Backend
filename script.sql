USE [master]
GO
/****** Object:  Database [ProductDb]    Script Date: 24-03-2025 17:49:10 ******/
CREATE DATABASE [ProductDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ProductDb', FILENAME = N'C:\Users\NagaSaiRam\ProductDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ProductDb_log', FILENAME = N'C:\Users\NagaSaiRam\ProductDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ProductDb] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ProductDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ProductDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ProductDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ProductDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ProductDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ProductDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [ProductDb] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ProductDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ProductDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ProductDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ProductDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ProductDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ProductDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ProductDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ProductDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ProductDb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ProductDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ProductDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ProductDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ProductDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ProductDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ProductDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ProductDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ProductDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ProductDb] SET  MULTI_USER 
GO
ALTER DATABASE [ProductDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ProductDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ProductDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ProductDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ProductDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ProductDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ProductDb] SET QUERY_STORE = OFF
GO
USE [ProductDb]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CartProducts]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartProducts](
	[CartId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carts]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carts](
	[CartId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CartId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[UserId] [int] NULL,
	[ProductId] [int] NULL,
	[OrderDate] [date] NULL,
	[Quantity] [int] NULL,
	[Total] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[Image] [nvarchar](max) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Rating] [float] NOT NULL,
	[Stock] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[isActive] [int] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password_hash] [varchar](255) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[created_at] [datetime] NULL,
	[role] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wishlist]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wishlist](
	[ProductId] [int] NULL,
	[UserId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_CategoryId]    Script Date: 24-03-2025 17:49:10 ******/
CREATE NONCLUSTERED INDEX [IX_Products_CategoryId] ON [dbo].[Products]
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[CartProducts]  WITH CHECK ADD FOREIGN KEY([CartId])
REFERENCES [dbo].[Carts] ([CartId])
GO
ALTER TABLE [dbo].[CartProducts]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Carts]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [fk_orders_product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [fk_orders_product]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories_CategoryId]
GO
ALTER TABLE [dbo].[Wishlist]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Wishlist]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([id])
GO
/****** Object:  StoredProcedure [dbo].[GetUserByEmail]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserByEmail]
    @Email NVARCHAR(100),
	@Password NVARCHAR(100),
	@Role NVARCHAR(100)
AS
BEGIN
	DECLARE @IsUserExists INT;
	DECLARE @V_Id INT;

	SELECT @V_Id = id FROM Users WITH (NOLOCK) WHERE email = @Email AND password_hash = @Password AND role = @Role;
	SELECT @IsUserExists = COUNT(UserId) FROM Wishlist WITH (NOLOCK) WHERE UserId = @V_Id;

	IF @IsUserExists > 0
		BEGIN
			SELECT u.id,u.username,u.role,STRING_AGG(w.ProductId, ',') AS ProductIds
			FROM Users u WITH(NOLOCK)
			INNER JOIN Wishlist w WITH (NOLOCK) ON w.UserId = u.id
			WHERE u.email = @Email AND u.password_hash = @Password AND role = @Role
			GROUP BY u.id,u.role,u.username;
		END
	ELSE
		BEGIN 
			SELECT id,username,role,'' AS ProductIds FROM Users  WITH(NOLOCK) WHERE email = @Email AND password_hash = @Password AND role = @Role;
		END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_AddToCart]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_AddToCart]
    @UserId INT,
    @ProductId INT,
    @Quantity INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CartId INT;
    DECLARE @Stock INT;
    DECLARE @CurrentQuantity INT;

    SELECT @Stock = Stock FROM Products WITH(NOLOCK) WHERE id = @ProductId;

    IF @Stock IS NULL
    BEGIN
        -- Product not found
        SELECT -2 AS Answer; -- Product Not found
        RETURN;
    END

    SELECT @CartId = CartId FROM Carts WITH(NOLOCK) WHERE UserId = @UserId;

    IF @CartId IS NULL
    BEGIN
        INSERT INTO Carts (UserId) VALUES (@UserId);
        SELECT @CartId = CartId FROM Carts WITH(NOLOCK) WHERE UserId = @UserId;
    END;

    SELECT @CurrentQuantity = Quantity FROM CartProducts WITH(NOLOCK) WHERE CartId = @CartId AND ProductId = @ProductId;

    IF @CurrentQuantity IS NOT NULL
    BEGIN
        -- Product already in cart
        IF @CurrentQuantity + @Quantity <= @Stock
        BEGIN
            UPDATE CartProducts
            SET Quantity = @CurrentQuantity + @Quantity
            WHERE CartId = @CartId AND ProductId = @ProductId;
            SELECT 1 AS Answer; -- Success
        END
        ELSE
        BEGIN
            SELECT 0 AS Answer; -- Quantity exceeds stock
        END
    END
    ELSE
    BEGIN
        -- Product not in cart
        IF @Quantity <= @Stock
        BEGIN
            INSERT INTO CartProducts (CartId, ProductId, Quantity) VALUES (@CartId, @ProductId, @Quantity);
            SELECT 1 AS Answer; -- Success
        END
        ELSE
        BEGIN
            SELECT 0 AS Answer; -- Quantity exceeds stock
        END
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_AddUser]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_AddUser]
		@Username NVARCHAR(100),
		@Email NVARCHAR(100),
		@Password VARCHAR(255),
		@Role VARCHAR(20)
AS
BEGIN
	DECLARE @UserCount INT;

	SELECT @UserCount = COUNT(id) FROM Users WITH (NOLOCK) WHERE email = @Email;

	IF @UserCount IS NULL
		BEGIN
			INSERT INTO Users (username,password_hash,email,created_at,role) VALUES(@Username,@Password,@Email,GETDATE(),@Role);
			SELECT 1 AS ANSWER;
		END;
	ELSE
		BEGIN
			SELECT -1 AS ANSWER;
		END;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCart]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetCart]
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT p.Id, p.Title, cp.Quantity,p.Price,p.Image,p.Stock
    FROM CartProducts cp WITH(NOLOCK)
    INNER JOIN Carts c WITH (NOLOCK) ON cp.CartId = c.CartId
    INNER JOIN Products p WITH (NOLOCK) ON cp.ProductId = p.Id
    WHERE c.UserId = @UserId AND p.isActive = 1;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCategories]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetCategories]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM Categories;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetOrDeleteProduct]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetOrDeleteProduct]
		@Id INT,
		@IsDelete BIT
AS
BEGIN
	IF @IsDelete = 1
		BEGIN
			UPDATE Products SET isActive = 0 WHERE id = @Id;
		END;
	ELSE
		BEGIN
			SELECT Id,Title,Image,Price,Stock,Description FROM Products WHERE id = @Id;
		END;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetOrders]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetOrders]
	@UserId INT
AS
BEGIN
	SELECT o.OrderDate,o.Total,p.Title,o.Quantity,p.Price
	FROM Orders o WITH(NOLOCK)
	INNER JOIN Products p WITH (NOLOCK) ON o.ProductId = p.Id
	WHERE o.UserId = @UserId
	ORDER BY o.Orderdate DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetProducts]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetProducts]
		@Id INT
AS
BEGIN
	IF @Id = -1
	BEGIN
	SELECT * FROM Products WHERE isActive = 1;
	END
	ELSE
	BEGIN
	SELECT * FROM Products WHERE isActive = 1 AND CategoryId = @Id;
	END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetWishList]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetWishList]
	@UserId int
AS
BEGIN
	SELECT p.Id, p.Title,p.Price,p.Image
	FROM Products p WITH(NOLOCK)
	INNER JOIN Wishlist w WITH (NOLOCK) ON p.id = w.ProductId
	INNER JOIN Users u WITH (NOLOCK) ON u.id = w.UserId
	WHERE u.id = @UserId AND p.isActive = 1;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertCategory]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertCategory]
		@Category NVARCHAR(100),
		@Id INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @InsertedId TABLE (Id INT);

    INSERT INTO Categories (Name)
    OUTPUT INSERTED.Id INTO @InsertedId
    VALUES (@Category);

    SELECT @Id = Id FROM @InsertedId;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertOrDeleteWishlist]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertOrDeleteWishlist]
		@UserId INT,
		@ProductId	INT,
		@IsInsert BIT

AS
BEGIN
	IF @IsInsert = 1
		BEGIN
			INSERT INTO Wishlist (ProductId,UserId) VALUES (@ProductId,@UserId)
		END
	ELSE
		BEGIN
			DELETE FROM Wishlist WHERE UserId = @UserId AND ProductId = @ProductId
		END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertOrder]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertOrder]
					@UserId	INT,
					@ProductId INT,
					@Date DATE,
					@Quantity INT,
					@Price DECIMAL
AS
BEGIN
	DECLARE @IsThere INT;
	DECLARE @Total INT;
	DECLARE @TotalPrice DECIMAL;

	SET @TotalPrice = @Quantity * @Price;

	SELECT @IsThere = COUNT(UserId) FROM Orders WITH(NOLOCK) WHERE UserId = @UserId AND ProductId = @ProductId AND OrderDate = @Date;
	SELECT @Total = Total FROM Orders WITH(NOLOCK) WHERE UserId = @UserId AND ProductId = @ProductId AND OrderDate = @Date;

	IF @IsThere > 0
		BEGIN
			UPDATE Orders SET Quantity = Quantity + @Quantity, Total = Total + @TotalPrice WHERE UserId = @UserId AND ProductId = @ProductId AND OrderDate = @Date;
		END;
	ELSE
		BEGIN
			INSERT INTO Orders(UserId,ProductId,OrderDate,Quantity,Total) VALUES(@UserId,@ProductId,@Date,@Quantity,@Quantity*@Price);
		END;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertProduct]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_InsertProduct]
		@Title NVARCHAR(100),
		@Image NVARCHAR(100),
		@Price DECIMAL,
		@Stock INT,
		@Description NVARCHAR(100),
		@CategoryId INT,
		@Id INT
AS
	BEGIN
		DECLARE @IsProduct INT;
		IF @Id = -1
		BEGIN
			SELECT @IsProduct = COUNT(Id) FROM Products WITH (NOLOCK) WHERE Title = @Title AND Image = @Image AND Description = @Description AND CategoryId = @CategoryId;
			IF @IsProduct = 0
				BEGIN
					INSERT INTO Products (Title, Image, Price, Rating, Stock, Description, CategoryId) 
					VALUES (@Title, @Image, @Price, 0, @Stock, @Description,@CategoryId);
				END;
			ELSE
				BEGIN
					SELECT 'Product already exists' AS Reply;
				END;
		END;
		ELSE
			BEGIN
				UPDATE Products SET Title = @Title, Image = @Image, Price = @Price, Stock = @Stock,Description = @Description WHERE Id = @Id
			END;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Order]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Order]
	@UserId INT,
	@Quantity INT,
	@ProductId INT
AS
BEGIN
	DECLARE @Stock INT;
	DECLARE @Price DECIMAL;
	DECLARE @CartId Int;
	DECLARE @Date DATETIME;
	DECLARE @IsThere INT;
	DECLARE @Total INT;
	DECLARE @TotalPrice DECIMAL;

	SELECT @Stock = stock, @Price = Price FROM Products WITH (NOLOCK) WHERE id = @ProductId;
	SELECT @CartId = CartId From Carts WITH (NOLOCK) Where UserId = @UserId;
	SET @Date = GETDATE();

	IF @Stock - @Quantity >= 0
		BEGIN 
			UPDATE Products SET Stock = Stock - @Quantity WHERE id = @ProductId;
			DELETE FROM CartProducts WHERE CartId = @CartId AND ProductId = @ProductId;
			SET @TotalPrice = @Quantity * @Price;

			SELECT @IsThere = COUNT(UserId) FROM Orders WITH(NOLOCK) WHERE UserId = @UserId AND ProductId = @ProductId AND  CAST(OrderDate AS DATE) = CAST(@Date AS DATE);;
			SELECT @Total = Total FROM Orders WITH(NOLOCK) WHERE UserId = @UserId AND ProductId = @ProductId AND CAST(OrderDate AS DATE) = CAST(@Date AS DATE);

			IF @IsThere > 0
				BEGIN
					UPDATE Orders SET Quantity = Quantity + @Quantity, Total = Total + @TotalPrice WHERE UserId = @UserId AND ProductId = @ProductId AND CAST(OrderDate AS DATE) = CAST(@Date AS DATE);
				END;
	ELSE
		BEGIN
			INSERT INTO Orders(UserId,ProductId,OrderDate,Quantity,Total) VALUES(@UserId,@ProductId,@Date,@Quantity,@Quantity*@Price);
		END;
			SELECT 1 AS ANSWER;
		END;
	ELSE
		BEGIN
			SELECT -1 AS ANSWER;
		END;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_RemoveFromCart]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_RemoveFromCart]
	@UserId INT,
    @CartProductId INT,
	@Remove BIT
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @Quantity INT;
	DECLARE	@CartId Int;

	SELECT @CartId = CartId FROM Carts WITH (NOLOCK) WHERE UserId = @UserId;
	SELECT @Quantity = Quantity FROM CartProducts WITH (NOLOCK) WHERE CartId = @CartId AND ProductId = @CartProductId;

	IF @Remove = 1
	BEGIN
		DELETE FROM CartProducts WHERE CartId = @CartId AND ProductId = @CartProductId;
	END

	IF @Quantity > 1 AND @Remove = 0
		BEGIN
			UPDATE CartProducts SET Quantity = @Quantity - 1
			WHERE CartId = @CartId AND ProductId = @CartProductId
		END
	ELSE
		BEGIN
			DELETE FROM CartProducts WHERE ProductId = @CartProductId;
		END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateUserName]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateUserName] 
		@UserName NVARCHAR(100),
		@Id INT
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE Users SET username = @UserName	WHERE id = @Id;
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_AddUser]    Script Date: 24-03-2025 17:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_AddUser]
		@Username NVARCHAR(100),
		@Email NVARCHAR(100),
		@Password NVARCHAR(255),
		@Role VARCHAR(20)
AS
BEGIN
	DECLARE @UserCount INT;

	SELECT @UserCount = COUNT(id) FROM Users WITH (NOLOCK) WHERE email = @Email;

	IF @UserCount = 0
		BEGIN
			INSERT INTO Users (username,password_hash,email,created_at,role) VALUES(@Username,@Password,@Email,GETDATE(),@Role);
			SELECT 1 AS ANSWER;
		END;
	ELSE
		BEGIN
			SELECT -1 AS ANSWER;
		END;
END;
GO
USE [master]
GO
ALTER DATABASE [ProductDb] SET  READ_WRITE 
GO
