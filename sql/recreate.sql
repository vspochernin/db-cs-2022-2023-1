USE [master]
GO

DROP DATABASE [Salon]
GO

/****** Object:  Database [Salon]    Script Date: 05.12.2022 23:10:24 ******/
CREATE DATABASE [Salon]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Salon', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MYSERVER\MSSQL\DATA\Salon.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Salon_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MYSERVER\MSSQL\DATA\Salon_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Salon] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Salon].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Salon] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Salon] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Salon] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Salon] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Salon] SET ARITHABORT OFF 
GO
ALTER DATABASE [Salon] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Salon] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Salon] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Salon] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Salon] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Salon] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Salon] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Salon] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Salon] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Salon] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Salon] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Salon] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Salon] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Salon] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Salon] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Salon] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Salon] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Salon] SET RECOVERY FULL 
GO
ALTER DATABASE [Salon] SET  MULTI_USER 
GO
ALTER DATABASE [Salon] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Salon] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Salon] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Salon] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Salon] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Salon] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Salon', N'ON'
GO
ALTER DATABASE [Salon] SET QUERY_STORE = OFF
GO
USE [Salon]
GO
/****** Object:  Table [dbo].[records]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[records](
	[record_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[author] [nvarchar](50) NOT NULL,
	[price] [money] NOT NULL,
	[count] [int] NOT NULL,
 CONSTRAINT [PK_records] PRIMARY KEY CLUSTERED 
(
	[record_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[showAllRecords]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[showAllRecords] AS
SELECT record_id AS Артикул, title AS Название, author AS Автор, price AS Цена, count AS Количество
FROM records;

GO
/****** Object:  Table [dbo].[orders]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[client_id] [int] NOT NULL,
	[employee_id] [int] NULL,
	[status_id] [int] NOT NULL,
	[amount] [money] NOT NULL,
	[order_datetime] [datetime] NOT NULL,
 CONSTRAINT [PK_orders] PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[statuses]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[statuses](
	[status_id] [int] NOT NULL,
	[text] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_statuses] PRIMARY KEY CLUSTERED 
(
	[status_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[showAllOrders]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[showAllOrders] AS
SELECT order_id       AS 'Номер заказа',
       client_id      AS 'Номер клиента',
       employee_id    AS 'Номер сотрудника',
       text           AS 'Статус заказа',
       amount         AS 'Сумма заказа',
       order_datetime AS 'Дата и время заказа'
FROM orders,
     statuses
WHERE orders.status_id = statuses.status_id;
GO
/****** Object:  Table [dbo].[clients]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clients](
	[client_id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [nvarchar](50) NOT NULL,
	[last_name] [nvarchar](50) NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[address] [nvarchar](50) NOT NULL,
	[login_id] [int] NOT NULL,
	[dob] [date] NOT NULL,
	[phone] [nchar](11) NOT NULL,
 CONSTRAINT [PK_clients] PRIMARY KEY CLUSTERED 
(
	[client_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[showAllClients]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[showAllClients] AS
SELECT client_id  AS 'Номер клиента',
       first_name AS 'Имя',
       last_name  AS 'Фамилия',
       email      AS 'Электронная почта',
       address    AS 'Адрес',
       dob        AS 'Дата рождения',
       phone      AS 'Номер телефона'
FROM clients;
GO
/****** Object:  Table [dbo].[reviews]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reviews](
	[review_id] [int] IDENTITY(1,1) NOT NULL,
	[record_id] [int] NOT NULL,
	[client_id] [int] NOT NULL,
	[text] [ntext] NOT NULL,
 CONSTRAINT [PK_reviews] PRIMARY KEY CLUSTERED 
(
	[review_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[showAllReviews]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[showAllReviews] AS
SELECT review_id         AS 'Номер отзыва',
       reviews.record_id AS 'Артикул',
       title             AS 'Название записи',
       client_id         AS 'Номер клиента',
       text              AS 'Текст рекомендации'
FROM reviews,
     records
WHERE reviews.record_id = records.record_id;
GO
/****** Object:  Table [dbo].[recommendations]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[recommendations](
	[recommendation_id] [int] IDENTITY(1,1) NOT NULL,
	[employee_id] [int] NOT NULL,
	[client_id] [int] NOT NULL,
	[text] [ntext] NOT NULL,
	[recommendation_datetime] [datetime] NOT NULL,
 CONSTRAINT [PK_recommendations] PRIMARY KEY CLUSTERED 
(
	[recommendation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[showAllRecommendations]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[showAllRecommendations] AS
SELECT recommendation_id       AS 'Номер рекомендации',
       employee_id             AS 'Номер сотрудника',
       client_id               AS 'Номер клиента',
       text                    AS 'Текст рекомендации',
       recommendation_datetime AS 'Дата и время рекомендации'
FROM recommendations;
GO
/****** Object:  Table [dbo].[employees]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employees](
	[employee_id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [nvarchar](50) NOT NULL,
	[last_name] [nvarchar](50) NOT NULL,
	[salary] [money] NOT NULL,
	[login_id] [int] NOT NULL,
 CONSTRAINT [PK_employees] PRIMARY KEY CLUSTERED 
(
	[employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[showAllEmployees]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[showAllEmployees] AS
SELECT employee_id AS 'Номер сотрудника',
       first_name  AS 'Имя',
       last_name   AS 'Фамилия',
       salary      AS 'Зарплата'
FROM employees;
GO
/****** Object:  View [dbo].[showAllStatuses]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[showAllStatuses] AS
SELECT text AS 'Текст статуса'
FROM statuses;
GO
/****** Object:  Table [dbo].[orders_records]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_records](
	[order_id] [int] NOT NULL,
	[record_id] [int] NOT NULL,
	[count] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[showMostPurchased]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[showMostPurchased] AS
	SELECT TOP 10
	records.record_id AS Артикул, title AS Название, author AS Автор, price AS Цена, SUM(orders_records.count) AS 'Количество продаж'
	FROM records
	JOIN orders_records ON orders_records.record_id = records.record_id
	JOIN orders ON orders.order_id = orders_records.order_id
	WHERE orders.status_id = 2
	GROUP BY records.record_id, title, author, price
	ORDER BY 'Количество продаж' DESC;
GO
/****** Object:  Table [dbo].[logins]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[logins](
	[login_id] [int] IDENTITY(1,1) NOT NULL,
	[login] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_logins] PRIMARY KEY CLUSTERED 
(
	[login_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[recommendations_records]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[recommendations_records](
	[recommendation_id] [int] NOT NULL,
	[record_id] [int] NOT NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[clients] ON 

INSERT [dbo].[clients] ([client_id], [first_name], [last_name], [email], [address], [login_id], [dob], [phone]) VALUES (1, N'Василий', N'Пупкин', N'pupkin@gmail.com', N'Адрес Пупкина', 4, CAST(N'2000-10-20' AS Date), N'79876543210')
INSERT [dbo].[clients] ([client_id], [first_name], [last_name], [email], [address], [login_id], [dob], [phone]) VALUES (2, N'Иван', N'Иваноv', N'ivanov@mail.ru', N'Адрес Иванова', 5, CAST(N'2000-10-21' AS Date), N'70123456789')
INSERT [dbo].[clients] ([client_id], [first_name], [last_name], [email], [address], [login_id], [dob], [phone]) VALUES (3, N'Владислав', N'Почернин', N'vspochernin@gmail.com', N'Санкт-Петербург', 6, CAST(N'2008-12-04' AS Date), N'12345678901')
SET IDENTITY_INSERT [dbo].[clients] OFF
GO
SET IDENTITY_INSERT [dbo].[employees] ON 

INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [salary], [login_id]) VALUES (1, N'Хороший', N'Продавец', 30000.0000, 2)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [salary], [login_id]) VALUES (2, N'Плохой', N'Продавец', 15000.0000, 3)
SET IDENTITY_INSERT [dbo].[employees] OFF
GO
SET IDENTITY_INSERT [dbo].[logins] ON 

INSERT [dbo].[logins] ([login_id], [login], [password]) VALUES (1, N'admin', N'7ADC785BE4A31EFF6783871FF63E18F1')
INSERT [dbo].[logins] ([login_id], [login], [password]) VALUES (2, N'good_prod', N'A970E5EF63B96E6387605932F290AF7D')
INSERT [dbo].[logins] ([login_id], [login], [password]) VALUES (3, N'bad_prod', N'C25E6F53264D6DACB6504E7637909DE3')
INSERT [dbo].[logins] ([login_id], [login], [password]) VALUES (4, N'pupkin', N'B25BDC597954A89BD11B907004890A1D')
INSERT [dbo].[logins] ([login_id], [login], [password]) VALUES (5, N'ivanov', N'828693DFD5EB38CEA6BEFAC467E0BB88')
INSERT [dbo].[logins] ([login_id], [login], [password]) VALUES (6, N'vspochernin', N'76D80224611FC919A5D54F0FF9FBA446')
SET IDENTITY_INSERT [dbo].[logins] OFF
GO
SET IDENTITY_INSERT [dbo].[orders] ON 

INSERT [dbo].[orders] ([order_id], [client_id], [employee_id], [status_id], [amount], [order_datetime]) VALUES (1, 1, 1, 2, 1000.0000, CAST(N'2022-11-23T12:25:56.607' AS DateTime))
INSERT [dbo].[orders] ([order_id], [client_id], [employee_id], [status_id], [amount], [order_datetime]) VALUES (2, 2, 2, 4, 1301.1000, CAST(N'2022-11-23T12:25:56.610' AS DateTime))
INSERT [dbo].[orders] ([order_id], [client_id], [employee_id], [status_id], [amount], [order_datetime]) VALUES (3, 1, NULL, 3, 520.4400, CAST(N'2022-11-23T12:26:05.847' AS DateTime))
INSERT [dbo].[orders] ([order_id], [client_id], [employee_id], [status_id], [amount], [order_datetime]) VALUES (4, 1, 1, 2, 1351.1000, CAST(N'2022-12-05T18:53:54.627' AS DateTime))
INSERT [dbo].[orders] ([order_id], [client_id], [employee_id], [status_id], [amount], [order_datetime]) VALUES (5, 1, 1, 2, 303.6000, CAST(N'2022-12-05T18:54:17.513' AS DateTime))
INSERT [dbo].[orders] ([order_id], [client_id], [employee_id], [status_id], [amount], [order_datetime]) VALUES (6, 1, 1, 2, 9000.0000, CAST(N'2022-12-05T18:54:22.893' AS DateTime))
INSERT [dbo].[orders] ([order_id], [client_id], [employee_id], [status_id], [amount], [order_datetime]) VALUES (7, 3, 1, 2, 4051.2000, CAST(N'2022-12-05T19:35:08.150' AS DateTime))
INSERT [dbo].[orders] ([order_id], [client_id], [employee_id], [status_id], [amount], [order_datetime]) VALUES (8, 3, 1, 2, 800.0000, CAST(N'2022-12-05T21:50:48.820' AS DateTime))
INSERT [dbo].[orders] ([order_id], [client_id], [employee_id], [status_id], [amount], [order_datetime]) VALUES (9, 3, NULL, 1, 14044.0000, CAST(N'2022-12-05T22:56:41.013' AS DateTime))
SET IDENTITY_INSERT [dbo].[orders] OFF
GO
INSERT [dbo].[orders_records] ([order_id], [record_id], [count]) VALUES (1, 1, 10)
INSERT [dbo].[orders_records] ([order_id], [record_id], [count]) VALUES (2, 1, 5)
INSERT [dbo].[orders_records] ([order_id], [record_id], [count]) VALUES (2, 2, 5)
INSERT [dbo].[orders_records] ([order_id], [record_id], [count]) VALUES (2, 3, 5)
INSERT [dbo].[orders_records] ([order_id], [record_id], [count]) VALUES (3, 1, 2)
INSERT [dbo].[orders_records] ([order_id], [record_id], [count]) VALUES (3, 2, 2)
INSERT [dbo].[orders_records] ([order_id], [record_id], [count]) VALUES (3, 3, 2)
INSERT [dbo].[orders_records] ([order_id], [record_id], [count]) VALUES (4, 1, 10)
INSERT [dbo].[orders_records] ([order_id], [record_id], [count]) VALUES (4, 3, 5)
INSERT [dbo].[orders_records] ([order_id], [record_id], [count]) VALUES (5, 4, 3)
INSERT [dbo].[orders_records] ([order_id], [record_id], [count]) VALUES (9, 3, 200)
INSERT [dbo].[orders_records] ([order_id], [record_id], [count]) VALUES (6, 2, 100)
INSERT [dbo].[orders_records] ([order_id], [record_id], [count]) VALUES (7, 1, 26)
INSERT [dbo].[orders_records] ([order_id], [record_id], [count]) VALUES (7, 2, 15)
INSERT [dbo].[orders_records] ([order_id], [record_id], [count]) VALUES (7, 4, 1)
INSERT [dbo].[orders_records] ([order_id], [record_id], [count]) VALUES (8, 1, 8)
GO
SET IDENTITY_INSERT [dbo].[recommendations] ON 

INSERT [dbo].[recommendations] ([recommendation_id], [employee_id], [client_id], [text], [recommendation_datetime]) VALUES (1, 1, 1, N'Очень рекомендую послушать!', CAST(N'2022-11-23T12:23:00.473' AS DateTime))
INSERT [dbo].[recommendations] ([recommendation_id], [employee_id], [client_id], [text], [recommendation_datetime]) VALUES (2, 2, 2, N'Ненавижу свою работу!', CAST(N'2022-11-23T12:23:00.477' AS DateTime))
SET IDENTITY_INSERT [dbo].[recommendations] OFF
GO
INSERT [dbo].[recommendations_records] ([recommendation_id], [record_id]) VALUES (1, 1)
INSERT [dbo].[recommendations_records] ([recommendation_id], [record_id]) VALUES (1, 2)
INSERT [dbo].[recommendations_records] ([recommendation_id], [record_id]) VALUES (1, 3)
INSERT [dbo].[recommendations_records] ([recommendation_id], [record_id]) VALUES (2, 1)
GO
SET IDENTITY_INSERT [dbo].[records] ON 

INSERT [dbo].[records] ([record_id], [title], [author], [price], [count]) VALUES (1, N'Smoke on the water', N'Deep Purpule', 100.0000, 63)
INSERT [dbo].[records] ([record_id], [title], [author], [price], [count]) VALUES (2, N'Бесполезно', N'Валентин Стрыкало', 90.0000, 92)
INSERT [dbo].[records] ([record_id], [title], [author], [price], [count]) VALUES (3, N'25 к 10', N'Аквариум', 70.2200, 102)
INSERT [dbo].[records] ([record_id], [title], [author], [price], [count]) VALUES (4, N'Hey you', N'Pink Floyd', 101.2000, 296)
INSERT [dbo].[records] ([record_id], [title], [author], [price], [count]) VALUES (5, N'Cosmos2016', N'Yuki', 170.3200, 11)
INSERT [dbo].[records] ([record_id], [title], [author], [price], [count]) VALUES (6, N'Гоша Рубчинский', N'Слава КПСС', 10.0000, 1)
SET IDENTITY_INSERT [dbo].[records] OFF
GO
SET IDENTITY_INSERT [dbo].[reviews] ON 

INSERT [dbo].[reviews] ([review_id], [record_id], [client_id], [text]) VALUES (1, 2, 1, N'Теперь это моя любимая песня!')
INSERT [dbo].[reviews] ([review_id], [record_id], [client_id], [text]) VALUES (2, 1, 2, N'Рок - отстой!')
INSERT [dbo].[reviews] ([review_id], [record_id], [client_id], [text]) VALUES (3, 6, 3, N'Крутая')
SET IDENTITY_INSERT [dbo].[reviews] OFF
GO
INSERT [dbo].[statuses] ([status_id], [text]) VALUES (1, N'Заказ создан')
INSERT [dbo].[statuses] ([status_id], [text]) VALUES (2, N'Заказ обработан сотрудником')
INSERT [dbo].[statuses] ([status_id], [text]) VALUES (3, N'Заказ отменен клиентом')
INSERT [dbo].[statuses] ([status_id], [text]) VALUES (4, N'Заказ отменен сотрудником')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_clients]    Script Date: 05.12.2022 23:10:24 ******/
ALTER TABLE [dbo].[clients] ADD  CONSTRAINT [IX_clients] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [U_email]    Script Date: 05.12.2022 23:10:24 ******/
ALTER TABLE [dbo].[clients] ADD  CONSTRAINT [U_email] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__clients__C2C971DA1156DA85]    Script Date: 05.12.2022 23:10:24 ******/
ALTER TABLE [dbo].[clients] ADD  CONSTRAINT [UQ__clients__C2C971DA1156DA85] UNIQUE NONCLUSTERED 
(
	[login_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__employee__C2C971DAB16F48A1]    Script Date: 05.12.2022 23:10:24 ******/
ALTER TABLE [dbo].[employees] ADD  CONSTRAINT [UQ__employee__C2C971DAB16F48A1] UNIQUE NONCLUSTERED 
(
	[login_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_logins]    Script Date: 05.12.2022 23:10:24 ******/
ALTER TABLE [dbo].[logins] ADD  CONSTRAINT [IX_logins] UNIQUE NONCLUSTERED 
(
	[login] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[clients]  WITH CHECK ADD  CONSTRAINT [FK_clients_logins2] FOREIGN KEY([login_id])
REFERENCES [dbo].[logins] ([login_id])
GO
ALTER TABLE [dbo].[clients] CHECK CONSTRAINT [FK_clients_logins2]
GO
ALTER TABLE [dbo].[employees]  WITH CHECK ADD  CONSTRAINT [FK_employees_logins1] FOREIGN KEY([login_id])
REFERENCES [dbo].[logins] ([login_id])
GO
ALTER TABLE [dbo].[employees] CHECK CONSTRAINT [FK_employees_logins1]
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD  CONSTRAINT [FK_orders_clients] FOREIGN KEY([client_id])
REFERENCES [dbo].[clients] ([client_id])
GO
ALTER TABLE [dbo].[orders] CHECK CONSTRAINT [FK_orders_clients]
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD  CONSTRAINT [FK_orders_employees] FOREIGN KEY([employee_id])
REFERENCES [dbo].[employees] ([employee_id])
GO
ALTER TABLE [dbo].[orders] CHECK CONSTRAINT [FK_orders_employees]
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD  CONSTRAINT [FK_orders_statuses] FOREIGN KEY([status_id])
REFERENCES [dbo].[statuses] ([status_id])
GO
ALTER TABLE [dbo].[orders] CHECK CONSTRAINT [FK_orders_statuses]
GO
ALTER TABLE [dbo].[orders_records]  WITH CHECK ADD  CONSTRAINT [FK_orders_records_orders] FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([order_id])
GO
ALTER TABLE [dbo].[orders_records] CHECK CONSTRAINT [FK_orders_records_orders]
GO
ALTER TABLE [dbo].[orders_records]  WITH CHECK ADD  CONSTRAINT [FK_orders_records_records] FOREIGN KEY([record_id])
REFERENCES [dbo].[records] ([record_id])
GO
ALTER TABLE [dbo].[orders_records] CHECK CONSTRAINT [FK_orders_records_records]
GO
ALTER TABLE [dbo].[recommendations]  WITH CHECK ADD  CONSTRAINT [FK_recommendations_clients] FOREIGN KEY([client_id])
REFERENCES [dbo].[clients] ([client_id])
GO
ALTER TABLE [dbo].[recommendations] CHECK CONSTRAINT [FK_recommendations_clients]
GO
ALTER TABLE [dbo].[recommendations]  WITH CHECK ADD  CONSTRAINT [FK_recommendations_employees] FOREIGN KEY([employee_id])
REFERENCES [dbo].[employees] ([employee_id])
GO
ALTER TABLE [dbo].[recommendations] CHECK CONSTRAINT [FK_recommendations_employees]
GO
ALTER TABLE [dbo].[recommendations_records]  WITH CHECK ADD  CONSTRAINT [FK_recommendations_records_recommendations] FOREIGN KEY([recommendation_id])
REFERENCES [dbo].[recommendations] ([recommendation_id])
GO
ALTER TABLE [dbo].[recommendations_records] CHECK CONSTRAINT [FK_recommendations_records_recommendations]
GO
ALTER TABLE [dbo].[recommendations_records]  WITH CHECK ADD  CONSTRAINT [FK_recommendations_records_records] FOREIGN KEY([record_id])
REFERENCES [dbo].[records] ([record_id])
GO
ALTER TABLE [dbo].[recommendations_records] CHECK CONSTRAINT [FK_recommendations_records_records]
GO
ALTER TABLE [dbo].[reviews]  WITH CHECK ADD  CONSTRAINT [FK_reviews_clients] FOREIGN KEY([client_id])
REFERENCES [dbo].[clients] ([client_id])
GO
ALTER TABLE [dbo].[reviews] CHECK CONSTRAINT [FK_reviews_clients]
GO
ALTER TABLE [dbo].[reviews]  WITH CHECK ADD  CONSTRAINT [FK_reviews_records] FOREIGN KEY([record_id])
REFERENCES [dbo].[records] ([record_id])
GO
ALTER TABLE [dbo].[reviews] CHECK CONSTRAINT [FK_reviews_records]
GO
ALTER TABLE [dbo].[clients]  WITH CHECK ADD  CONSTRAINT [check_phone] CHECK  ((NOT [phone] like '%[^0-9]%'))
GO
ALTER TABLE [dbo].[clients] CHECK CONSTRAINT [check_phone]
GO
/****** Object:  StoredProcedure [dbo].[addClient]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addClient](@first_name AS NVARCHAR(50), @last_name AS NVARCHAR(50), @email AS NVARCHAR(50),
                                   @login AS NVARCHAR(50),
                                   @password AS NVARCHAR(50), @address AS NVARCHAR(50), @dob AS date,
                                   @phone AS NCHAR(11)) AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO logins(login, password) VALUES (@login, @password)

        DECLARE @login_id int = @@IDENTITY;

        INSERT INTO clients(first_name, last_name, email, address, login_id, dob, phone)
        VALUES (@first_name, @last_name, @email, @address, @login_id, @dob, @phone)
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[addEmployee]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addEmployee](@first_name AS NVARCHAR(50), @last_name AS NVARCHAR(50),
                                     @salary AS money, @login AS NVARCHAR(50), @password AS NVARCHAR(50)) AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO logins(login, password) VALUES (@login, @password)

        DECLARE @login_id int = @@IDENTITY;

        INSERT INTO employees(first_name, last_name, salary, login_id)
        VALUES (@first_name, @last_name, @salary, @login_id)
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[addOrder]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addOrder](@client_id AS int) AS
INSERT INTO orders(client_id, status_id, amount, order_datetime)
VALUES (@client_id, 1, 0, GETDATE());

GO
/****** Object:  StoredProcedure [dbo].[addRecommendation]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addRecommendation](@employee_id AS int, @client_id AS int, @text as NTEXT) AS
INSERT INTO recommendations(employee_id, client_id, text, recommendation_datetime)
VALUES (@employee_id, @client_id, @text, GETDATE());

GO
/****** Object:  StoredProcedure [dbo].[addRecord]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addRecord](@title AS NVARCHAR(50), @author AS NVARCHAR(50), @price AS money, @count AS int) AS
INSERT INTO records(title, author, price, count)
VALUES (@title, @author, @price, @count);

GO
/****** Object:  StoredProcedure [dbo].[addRecordToOrder]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addRecordToOrder](@order_id AS int, @record_id AS int, @count AS int) AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @record_count int = (SELECT records.count FROM records WHERE records.record_id = @record_id);
        DECLARE @record_price money = (SELECT records.price FROM records WHERE records.record_id = @record_id);
        DECLARE @order_amount money = (SELECT orders.amount FROM orders WHERE orders.order_id = @order_id);
        DECLARE @order_status int = (SELECT orders.status_id FROM orders WHERE orders.order_id = @order_id);

        IF (@order_status != 1)
            BEGIN
                THROW 50000, 'Невозможно добавить записи в завершенный заказ', 1;
            END

        IF (@count > @record_count)
            BEGIN
                THROW 50000, 'Недостаточно музыкальных записей на складе', 1;
            END

        UPDATE records
        SET records.count = @record_count - @count
        WHERE records.record_id = @record_id

        UPDATE orders
        SET orders.amount = @order_amount + (@record_price * @count)
        WHERE orders.order_id = @order_id;

        IF (EXISTS(SELECT *
                   FROM orders_records
                   WHERE orders_records.order_id = @order_id
                     AND orders_records.record_id = @record_id))
            BEGIN
                DECLARE @orders_records_count money = (SELECT orders_records.count
                                                       FROM orders_records
                                                       WHERE orders_records.order_id = @order_id
                                                         AND orders_records.record_id = @record_id);
                UPDATE orders_records
                SET orders_records.count = @orders_records_count + @count
                WHERE orders_records.order_id = @order_id
                  AND orders_records.record_id = @record_id;
            END
        ELSE
            BEGIN
                INSERT INTO orders_records(order_id, record_id, count) VALUES (@order_id, @record_id, @count)
            END
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[addRecordToRecommendation]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[addRecordToRecommendation](@recommendation_id AS int, @record_id AS int) AS
INSERT INTO recommendations_records(recommendation_id, record_id)
VALUES (@recommendation_id, @record_id);

GO
/****** Object:  StoredProcedure [dbo].[addReview]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addReview](@record_id AS int, @client_id AS int, @text AS NTEXT) AS
INSERT INTO reviews(record_id, client_id, text)
VALUES (@record_id, @client_id, @text);

GO
/****** Object:  StoredProcedure [dbo].[removeRecommendation]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[removeRecommendation](@recommendation_id AS int) AS
DELETE
FROM recommendations_records
WHERE recommendations_records.recommendation_id = @recommendation_id
DELETE
FROM recommendations
WHERE recommendations.recommendation_id = @recommendation_id;

GO
/****** Object:  StoredProcedure [dbo].[removeRecord]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[removeRecord](@record_id AS INT) AS
UPDATE records
SET records.count = 0
WHERE records.record_id = @record_id;

GO
/****** Object:  StoredProcedure [dbo].[removeRecordFromRecommendation]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*- [x] Удаление музыкальной записи из рекомендации (id рекомендации, id удаляемой музыкальной записи (таблица **recommendations_records**);*/

CREATE PROCEDURE [dbo].[removeRecordFromRecommendation](@recommendation_id AS int, @record_id AS int) AS
DELETE
FROM recommendations_records
WHERE recommendations_records.recommendation_id = @recommendation_id
  AND recommendations_records.record_id = @record_id;

GO
/****** Object:  StoredProcedure [dbo].[removeReview]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[removeReview](@review_id AS int) AS
DELETE
FROM reviews
WHERE review_id = @review_id;

GO
/****** Object:  StoredProcedure [dbo].[showOrderById]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[showOrderById](@order_id AS int) AS
	SELECT orders_records.record_id AS 'Артикул', title AS 'Название', author AS 'Автор', orders_records.count AS 'Количество'
	FROM orders
		JOIN orders_records ON orders_records.order_id = orders.order_id
		JOIN records ON records.record_id = orders_records.record_id
		WHERE orders.order_id = @order_id;
GO
/****** Object:  StoredProcedure [dbo].[showOrdersByClientEmail]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[showOrdersByClientEmail](@email AS NVARCHAR(50)) AS
SELECT order_id       AS 'Номер заказа',
       client_id      AS 'Номер клиента',
       employee_id    AS 'Номер сотрудника',
       text           AS 'Статус заказа',
       amount         AS 'Сумма заказа',
       order_datetime AS 'Дата и время заказа'
FROM orders,
     statuses
WHERE orders.client_id = (SELECT client_id FROM clients WHERE clients.email = @email)
  AND orders.status_id = statuses.status_id;
GO
/****** Object:  StoredProcedure [dbo].[showOrdersByClientId]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[showOrdersByClientId](@client_id AS int) AS
SELECT order_id       AS 'Номер заказа',
       client_id      AS 'Номер клиента',
       employee_id    AS 'Номер сотрудника',
       text           AS 'Статус заказа',
       amount         AS 'Сумма заказа',
       order_datetime AS 'Дата и время заказа'
FROM orders,
     statuses
WHERE orders.client_id = @client_id
  AND orders.status_id = statuses.status_id;
GO
/****** Object:  StoredProcedure [dbo].[showRecommendationById]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[showRecommendationById](@recommendation_id AS int) AS
	SELECT recommendations_records.record_id AS 'Артикул', title AS 'Название', author AS 'Автор'
		FROM recommendations
		JOIN recommendations_records ON recommendations_records.recommendation_id = recommendations.recommendation_id
		JOIN records ON records.record_id = recommendations_records.record_id
		WHERE recommendations.recommendation_id = @recommendation_id
		ORDER BY recommendations.recommendation_id;
GO
/****** Object:  StoredProcedure [dbo].[showRecommendationsOfClient]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[showRecommendationsOfClient](@client_id AS int) AS
	SELECT recommendation_id AS 'Номер рекомендации', employee_id AS 'Номер сотрудника', client_id AS 'Номер клиента',
		text AS 'Текст рекомендации', recommendation_datetime AS 'Дата и время рекомендации'
		FROM recommendations
		WHERE client_id = @client_id;
GO
/****** Object:  StoredProcedure [dbo].[showReviewsOfRecord]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[showReviewsOfRecord](@record_id AS int) AS
	SELECT review_id AS 'Номер отзыва', client_id AS 'Номер клиента', reviews.record_id AS 'Артикул', title AS 'Название',
		author AS 'Автор', text AS 'Текст рекомендации'
	FROM reviews, records
	WHERE reviews.record_id = @record_id AND records.record_id = @record_id;
GO
/****** Object:  StoredProcedure [dbo].[updateAdmin]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[updateAdmin](@login AS NVARCHAR(50), @password AS NVARCHAR(50)) AS
UPDATE logins
SET logins.login    = @login,
    logins.password = @password
WHERE logins.login_id = 1;

GO
/****** Object:  StoredProcedure [dbo].[updateClient]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[updateClient](@client_id AS int, @first_name AS NVARCHAR(50), @last_name AS NVARCHAR(50),
                                      @email AS NVARCHAR(50), @login AS NVARCHAR(50),
                                      @password AS NVARCHAR(50), @address AS NVARCHAR(50), @dob AS date,
                                      @phone AS NCHAR(11)) AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @login_id int = (SELECT clients.login_id FROM clients WHERE clients.client_id = @client_id);

        UPDATE logins
        SET logins.login    = @login,
            logins.password = @password
        WHERE logins.login_id = @login_id;

        UPDATE clients
        SET clients.first_name = @first_name,
            clients.last_name  = @last_name,
            clients.email      = @email,
            clients.address    = @address,
            clients.dob        = @dob,
            clients.phone      = @phone
        WHERE clients.client_id = @client_id;

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[updateEmployee]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[updateEmployee](@employee_id AS int, @first_name AS NVARCHAR(50), @last_name AS NVARCHAR(50),
                                        @salary AS money, @login AS NVARCHAR(50), @password AS NVARCHAR(50)) AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @login_id int = (SELECT employees.login_id FROM employees WHERE employees.employee_id = @employee_id);

        UPDATE logins
        SET logins.login    = @login,
            logins.password = @password
        WHERE logins.login_id = @login_id;


        UPDATE employees
        SET employees.first_name = @first_name,
            employees.last_name  = @last_name,
            employees.salary     = @salary
        WHERE employees.employee_id = @employee_id;

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[updateRecommendationText]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*- [x] Изменение текста рекомендации (id рекомендации, text) (таблица **recommendations**);*/

CREATE PROCEDURE [dbo].[updateRecommendationText](@recommendation_id AS int, @text AS NTEXT) AS
UPDATE recommendations
SET recommendations.text = @text
WHERE recommendations.recommendation_id = @recommendation_id;

GO
/****** Object:  StoredProcedure [dbo].[updateRecord]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[updateRecord](@record_id AS int, @title AS NVARCHAR(50), @author AS NVARCHAR(50),
                                      @price AS MONEY, @count AS int) AS
UPDATE records
SET records.title  = @title,
    records.author = @author,
    records.price  = @price,
    records.count  = @count
WHERE records.record_id = @record_id;

GO
/****** Object:  StoredProcedure [dbo].[updateStatusByClient]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[updateStatusByClient](@order_id AS int, @status_id AS int) AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @current_status_id int = (SELECT orders.status_id FROM orders WHERE orders.order_id = @order_id);

        IF (@current_status_id = '3' OR @current_status_id = '4')
            BEGIN
                THROW 50000, 'Заказ был отменен, его статус не изменить', 1;
            END

        IF (@current_status_id = '2')
            BEGIN
                THROW 50000, 'Заказ был обработан, его статус не изменить', 1;
            END

        IF (@status_id = '1')
            BEGIN
                THROW 50000, 'Статус созданного заказа невозможно изменить вручную', 1;
            END

        IF (@status_id = '3' OR @status_id = '4')
            BEGIN
                DECLARE @cursor CURSOR;
                DECLARE @record_id int;

                SET @cursor = CURSOR FOR SELECT orders_records.record_id
                                         FROM orders_records
                                         WHERE orders_records.order_id = @order_id;

                OPEN @cursor
                FETCH NEXT FROM @cursor INTO @record_id;

                WHILE @@FETCH_STATUS = 0
                    BEGIN
                        DECLARE @current_count int = (SELECT records.count
                                                      FROM records
                                                      WHERE records.record_id = @record_id);

                        UPDATE records
                        SET records.count = @current_count +
                                            (SELECT orders_records.count
                                             FROM orders_records
                                             WHERE orders_records.order_id = @order_id
                                               AND orders_records.record_id = @record_id)
                        WHERE records.record_id = @record_id;

                        FETCH NEXT FROM @cursor INTO @record_id
                    END;

                CLOSE @cursor;
                DEALLOCATE @cursor;
            END

        UPDATE orders
        SET orders.status_id = @status_id
        WHERE orders.order_id = @order_id;

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[updateStatusByEmployee]    Script Date: 05.12.2022 23:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[updateStatusByEmployee](@order_id AS int, @status_id AS int, @employee_id AS int) AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @current_status_id int = (SELECT orders.status_id FROM orders WHERE orders.order_id = @order_id);

        IF (@current_status_id = '3' OR @current_status_id = '4')
            BEGIN
                THROW 50000, 'Заказ был отменен, его статус не изменить', 1;
            END

        IF (@current_status_id = '2')
            BEGIN
                THROW 50000, 'Заказ был обработан, его статус не изменить', 1;
            END

        IF (@status_id = '1')
            BEGIN
                THROW 50000, 'Статус созданного заказа невозможно изменить вручную', 1;
            END

        IF (@status_id = '3' OR @status_id = '4')
            BEGIN
                DECLARE @cursor CURSOR;
                DECLARE @record_id int;

                SET @cursor = CURSOR FOR SELECT orders_records.record_id
                                         FROM orders_records
                                         WHERE orders_records.order_id = @order_id;

                OPEN @cursor
                FETCH NEXT FROM @cursor INTO @record_id;

                WHILE @@FETCH_STATUS = 0
                    BEGIN
                        DECLARE @current_count int = (SELECT records.count
                                                      FROM records
                                                      WHERE records.record_id = @record_id);

                        UPDATE records
                        SET records.count = @current_count +
                                            (SELECT orders_records.count
                                             FROM orders_records
                                             WHERE orders_records.order_id = @order_id
                                               AND orders_records.record_id = @record_id)
                        WHERE records.record_id = @record_id;

                        FETCH NEXT FROM @cursor INTO @record_id
                    END;

                CLOSE @cursor;
                DEALLOCATE @cursor;
            END

        UPDATE orders
        SET orders.status_id   = @status_id,
            orders.employee_id = @employee_id
        WHERE orders.order_id = @order_id;

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW
    END CATCH
END;
GO
USE [master]
GO
ALTER DATABASE [Salon] SET  READ_WRITE 
GO
