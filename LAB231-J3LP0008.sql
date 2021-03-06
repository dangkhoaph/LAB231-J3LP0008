USE [master]
GO
/****** Object:  Database [DreamTraveling]    Script Date: 8/14/2020 10:03:29 AM ******/
CREATE DATABASE [DreamTraveling]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DreamTraveling', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\DreamTraveling.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DreamTraveling_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\DreamTraveling_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DreamTraveling] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DreamTraveling].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DreamTraveling] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DreamTraveling] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DreamTraveling] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DreamTraveling] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DreamTraveling] SET ARITHABORT OFF 
GO
ALTER DATABASE [DreamTraveling] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DreamTraveling] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DreamTraveling] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DreamTraveling] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DreamTraveling] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DreamTraveling] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DreamTraveling] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DreamTraveling] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DreamTraveling] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DreamTraveling] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DreamTraveling] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DreamTraveling] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DreamTraveling] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DreamTraveling] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DreamTraveling] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DreamTraveling] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DreamTraveling] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DreamTraveling] SET RECOVERY FULL 
GO
ALTER DATABASE [DreamTraveling] SET  MULTI_USER 
GO
ALTER DATABASE [DreamTraveling] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DreamTraveling] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DreamTraveling] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DreamTraveling] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [DreamTraveling] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DreamTraveling', N'ON'
GO
USE [DreamTraveling]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 8/14/2020 10:03:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Booking](
	[BookingId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [varchar](50) NOT NULL,
	[BookingDate] [date] NOT NULL,
	[DiscountId] [varchar](50) NULL,
	[StatusId] [int] NOT NULL,
 CONSTRAINT [PK_Booking] PRIMARY KEY CLUSTERED 
(
	[BookingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BookingDetail]    Script Date: 8/14/2020 10:03:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookingDetail](
	[BookingDetailId] [int] IDENTITY(1,1) NOT NULL,
	[BookingId] [int] NOT NULL,
	[TourId] [int] NOT NULL,
	[Amount] [int] NOT NULL,
 CONSTRAINT [PK_BookingDetail] PRIMARY KEY CLUSTERED 
(
	[BookingDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Discount]    Script Date: 8/14/2020 10:03:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Discount](
	[DiscountId] [varchar](50) NOT NULL,
	[DiscountName] [varchar](50) NOT NULL,
	[Percentage] [int] NOT NULL,
	[ExpiryDate] [date] NOT NULL,
 CONSTRAINT [PK_Discount] PRIMARY KEY CLUSTERED 
(
	[DiscountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Role]    Script Date: 8/14/2020 10:03:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Role](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Status]    Script Date: 8/14/2020 10:03:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Status](
	[StatusId] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tour]    Script Date: 8/14/2020 10:03:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tour](
	[TourId] [int] IDENTITY(1,1) NOT NULL,
	[TourName] [varchar](250) NOT NULL,
	[Place] [varchar](50) NOT NULL,
	[FromDate] [date] NOT NULL,
	[ToDate] [date] NOT NULL,
	[Price] [float] NOT NULL,
	[Quota] [int] NOT NULL,
	[ImageLink] [varchar](250) NOT NULL,
	[ImportDate] [date] NOT NULL,
	[StatusId] [int] NOT NULL,
 CONSTRAINT [PK_Tour] PRIMARY KEY CLUSTERED 
(
	[TourId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 8/14/2020 10:03:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [varchar](50) NOT NULL,
	[Password] [varchar](50) NULL,
	[FullName] [varchar](50) NOT NULL,
	[FacebookId] [varchar](50) NULL,
	[FacebookLink] [varchar](250) NULL,
	[RoleId] [int] NOT NULL,
	[StatusId] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Booking] ON 

INSERT [dbo].[Booking] ([BookingId], [UserId], [BookingDate], [DiscountId], [StatusId]) VALUES (1, N'user1', CAST(N'2020-06-22' AS Date), N'E4IF6EIJ9X', 1)
INSERT [dbo].[Booking] ([BookingId], [UserId], [BookingDate], [DiscountId], [StatusId]) VALUES (2, N'user2', CAST(N'2020-06-22' AS Date), N'E4IF6EIJ9X', 1)
INSERT [dbo].[Booking] ([BookingId], [UserId], [BookingDate], [DiscountId], [StatusId]) VALUES (3, N'user1', CAST(N'2020-06-22' AS Date), NULL, 1)
SET IDENTITY_INSERT [dbo].[Booking] OFF
SET IDENTITY_INSERT [dbo].[BookingDetail] ON 

INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookingId], [TourId], [Amount]) VALUES (1, 1, 2, 5)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookingId], [TourId], [Amount]) VALUES (2, 1, 5, 21)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookingId], [TourId], [Amount]) VALUES (3, 1, 8, 10)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookingId], [TourId], [Amount]) VALUES (4, 2, 5, 1)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookingId], [TourId], [Amount]) VALUES (5, 2, 2, 3)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookingId], [TourId], [Amount]) VALUES (6, 3, 6, 7)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookingId], [TourId], [Amount]) VALUES (7, 3, 2, 5)
SET IDENTITY_INSERT [dbo].[BookingDetail] OFF
INSERT [dbo].[Discount] ([DiscountId], [DiscountName], [Percentage], [ExpiryDate]) VALUES (N'9SEXBZAQYK', N'Discount 1', 30, CAST(N'2020-06-01' AS Date))
INSERT [dbo].[Discount] ([DiscountId], [DiscountName], [Percentage], [ExpiryDate]) VALUES (N'E4IF6EIJ9X', N'Discount 3', 75, CAST(N'2020-07-01' AS Date))
INSERT [dbo].[Discount] ([DiscountId], [DiscountName], [Percentage], [ExpiryDate]) VALUES (N'RJO6CM3XAZ', N'Discount 2', 12, CAST(N'2020-06-01' AS Date))
INSERT [dbo].[Discount] ([DiscountId], [DiscountName], [Percentage], [ExpiryDate]) VALUES (N'USVNPFQLQN', N'Discount 4', 50, CAST(N'2020-08-01' AS Date))
INSERT [dbo].[Discount] ([DiscountId], [DiscountName], [Percentage], [ExpiryDate]) VALUES (N'VN3RGA8USI', N'Discount 5', 80, CAST(N'2020-08-01' AS Date))
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (1, N'Admin')
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (2, N'User')
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[Status] ON 

INSERT [dbo].[Status] ([StatusId], [StatusName]) VALUES (1, N'Active')
INSERT [dbo].[Status] ([StatusId], [StatusName]) VALUES (2, N'Deactive')
SET IDENTITY_INSERT [dbo].[Status] OFF
SET IDENTITY_INSERT [dbo].[Tour] ON 

INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (1, N'Tour Thai Lan 4N3D: Bangkok - Pattaya - Baiyoke Sky', N'Thai Lan', CAST(N'2020-08-13' AS Date), CAST(N'2020-08-17' AS Date), 6590000, 21, N'./images/ivivu-chua-wat-yanawa-450x265.jpg', CAST(N'2020-06-12' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (2, N'Tour Thai Lan 5N4D: Bangkok - Muangboran - Suanthai Pattaya', N'Thai Lan', CAST(N'2020-10-01' AS Date), CAST(N'2020-10-06' AS Date), 6990000, 18, N'./images/ivivu-suanthai-pattaya-450x265.jpg', CAST(N'2020-06-12' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (3, N'Tour Thai Lan 4N3D: Bangkok - Pattaya', N'Thai Lan', CAST(N'2020-08-18' AS Date), CAST(N'2020-08-22' AS Date), 6990000, 23, N'./images/ivivu-bangkok2-450x265.jpg', CAST(N'2020-06-12' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (4, N'Tour Thai Lan 5N4D: Bangkok - Pattaya bay VNA', N'Thai Lan', CAST(N'2020-10-02' AS Date), CAST(N'2020-10-07' AS Date), 7390000, 44, N'./images/ivivu-muang-boran11-450x265.jpg', CAST(N'2020-06-12' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (5, N'Tour Thai Lan 5N4D: BangKok - Pattaya (BL)', N'Thai Lan', CAST(N'2020-09-15' AS Date), CAST(N'2020-09-19' AS Date), 2500000, 22, N'./images/bangkok2-450x265.jpg', CAST(N'2020-06-12' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (6, N'Tour Thai Lan 5N4D: Bangkok - Pattaya - Cho Noi', N'Thai Lan', CAST(N'2020-09-15' AS Date), CAST(N'2020-09-19' AS Date), 2500000, 20, N'./images/bangkok-450x265.jpg', CAST(N'2020-06-12' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (7, N'Tour Thai Lan 5N4D: Pattaya - Bangkok (PG)', N'Thai Lan', CAST(N'2020-08-13' AS Date), CAST(N'2020-08-18' AS Date), 6990000, 52, N'./images/ivivu-vuon-nho-silverlake-450x265.jpg', CAST(N'2020-06-12' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (8, N'Tour Han Quoc 4N4D: Seoul - Nami - Everland (PG)', N'Han Quoc', CAST(N'2020-08-13' AS Date), CAST(N'2020-08-17' AS Date), 14990000, 44, N'./images/ivivu-namsan-seoul-tower-450x265.jpg', CAST(N'2020-06-12' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (9, N'Tour Myanmar 4N3D : Yangon - Bago (Bay VNA)', N'Myanmar', CAST(N'2020-09-15' AS Date), CAST(N'2020-09-19' AS Date), 2500000, 42, N'./images/myanmar-2-450x265.jpg', CAST(N'2020-06-21' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (10, N'Tour Lao 4N3D: Lao - Dong Bac Thai Lan', N'Lao', CAST(N'2020-08-18' AS Date), CAST(N'2020-08-22' AS Date), 6490000, 19, N'./images/ivivu-cong-vien-hoang-gia-450x265.jpg', CAST(N'2020-06-22' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (11, N'Tour Han Quoc 4N4D: Seoul - Dao Nami - Everland', N'Han Quoc', CAST(N'2020-09-15' AS Date), CAST(N'2020-09-19' AS Date), 2500000, 53, N'./images/ivivu-cong-vien-yeouido1-450x265.jpg', CAST(N'2020-06-22' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (14, N'Tour Dai Loan 4N4D: Dai Bac - Dai Trung - Gia Nghia - Cao Hung', N'Dai Loan', CAST(N'2020-08-13' AS Date), CAST(N'2020-08-17' AS Date), 10490000, 36, N'./images/ivivu-ho-nhat-nguyet2-450x265.jpg', CAST(N'2020-06-22' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (15, N'Tour Nhat Ban 6N5D: Osaka - Nara - Kyoto - Toyohashi - Yamanashi - Tokyo', N'Nhat Ban', CAST(N'2020-08-24' AS Date), CAST(N'2020-08-30' AS Date), 25888000, 27, N'./images/ivivu-fushimi-inari-450x265.png', CAST(N'2020-06-22' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (16, N'Tour Campuchia 4N3D: Bokor - Bien Kep - Dao Tho - Phnom Penh (Deal)', N'Campuchia', CAST(N'2020-09-15' AS Date), CAST(N'2020-09-19' AS Date), 2500000, 51, N'./images/ivivu-tour-campuchia-bokor-1-450x265.jpg', CAST(N'2020-06-22' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (17, N'Tour Nhat 6N5D: Osaka - Kobe - Kyoto - Phu Sy - Tokyo', N'Nhat Ban', CAST(N'2020-09-15' AS Date), CAST(N'2020-09-19' AS Date), 2500000, 34, N'./images/ivivu-vuon-hoa-tulip-nhat-450x265.png', CAST(N'2020-06-22' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (18, N'Tour Campuchia 4N3D: Siemreap - Phnom Penh (DEAL)', N'Campuchia', CAST(N'2020-08-18' AS Date), CAST(N'2020-08-22' AS Date), 3700000, 49, N'./images/ivivu-angkor-450x265.jpg', CAST(N'2020-06-22' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (19, N'Tour Campuchia 4N3D: Siem Riep - Phnom Penh (VK)', N'Campuchia', CAST(N'2020-08-18' AS Date), CAST(N'2020-08-22' AS Date), 3990000, 24, N'./images/ivivu-kampong-450x265.png', CAST(N'2020-06-22' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (20, N'Tour Campuchia 3N2D: Kratie - Preah Vihear - Stungtreng', N'Campuchia', CAST(N'2020-08-19' AS Date), CAST(N'2020-08-22' AS Date), 4080000, 18, N'./images/ivivu-ca-heo-song-mekong-450x265.png', CAST(N'2020-06-22' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (21, N'Tour Singapore 3N2D: Vuon Chim Jurong - Garden By The Bay - Sentosa', N'Singapore', CAST(N'2020-09-15' AS Date), CAST(N'2020-09-19' AS Date), 2500000, 38, N'./images/ivivu-singapore1-450x265.jpg', CAST(N'2020-06-22' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (22, N'Tour Malaysia 4N3D: Singapore - Malaysia', N'Malaysia', CAST(N'2020-08-13' AS Date), CAST(N'2020-08-17' AS Date), 8290000, 32, N'./images/ivivu-singapore7-450x265.jpg', CAST(N'2020-06-22' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (23, N'Tour Singapore 3N2D: Sentosa - Garden By The Bay', N'Singapore', CAST(N'2020-09-15' AS Date), CAST(N'2020-09-19' AS Date), 2500000, 24, N'./images/tour-singapore-3n2d-sea-aquarium-450x265.jpg', CAST(N'2020-06-22' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (24, N'Tour Singapore 5N4D: Singapore - Malaysia', N'Singapore', CAST(N'2020-09-15' AS Date), CAST(N'2020-09-19' AS Date), 2500000, 20, N'./images/tour-singapore-malay-nhac-nuoc-450x265.jpg', CAST(N'2020-06-22' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (25, N'Tour Singapore 5N4D: Sai Gon - Singapore - Malaysia', N'Singapore', CAST(N'2020-09-15' AS Date), CAST(N'2020-09-19' AS Date), 2500000, 19, N'./images/ivivu-singapore4-450x265.jpg', CAST(N'2020-06-22' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (26, N'Tour Da Nang 4N3D: HCM - Da Nang - Ba Na - Hoi An - Hue - Quang Binh', N'Da Nang', CAST(N'2020-08-18' AS Date), CAST(N'2020-08-22' AS Date), 4599000, 39, N'./images/tour-da-nangba-na-hill-cau-vang-450x265.jpg', CAST(N'2020-06-22' AS Date), 1)
INSERT [dbo].[Tour] ([TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) VALUES (27, N'Tour Da Nang 4N3D: Hoi An - Ba Na - Hue - Dong Phong Nha/Thien Duong (VT)', N'Da Nang', CAST(N'2020-08-14' AS Date), CAST(N'2020-08-18' AS Date), 3250000, 48, N'./images/hoi-an-450x265.jpg', CAST(N'2020-06-22' AS Date), 1)
SET IDENTITY_INSERT [dbo].[Tour] OFF
INSERT [dbo].[Users] ([UserId], [Password], [FullName], [FacebookId], [FacebookLink], [RoleId], [StatusId]) VALUES (N'admin1', N'123456', N'Admin 1', NULL, NULL, 1, 1)
INSERT [dbo].[Users] ([UserId], [Password], [FullName], [FacebookId], [FacebookLink], [RoleId], [StatusId]) VALUES (N'admin2', N'123456', N'Admin 2', NULL, NULL, 1, 2)
INSERT [dbo].[Users] ([UserId], [Password], [FullName], [FacebookId], [FacebookLink], [RoleId], [StatusId]) VALUES (N'khoaphd', N'123456', N'Phan Huynh Dang Khoa', NULL, NULL, 1, 1)
INSERT [dbo].[Users] ([UserId], [Password], [FullName], [FacebookId], [FacebookLink], [RoleId], [StatusId]) VALUES (N'playwithlif313@gmail.com', NULL, N'Khoa Phan', N'1813772792096643', N'https://www.facebook.com/app_scoped_user_id/YXNpZADpBWEdkbm5QOXY3UzBXdTRjN0RzaUFLLTREYkU5QzRxVGV4TFQ2TW4zeExqekJNcnZAyWFp0YXdPMkdvVEpaUDg4dEJfWjgyWGMyT0NfZADF0cDR4TEFvMllQVk9CdnlQb3IxMWUwd3FCQXFnQkFjVDBj/', 2, 1)
INSERT [dbo].[Users] ([UserId], [Password], [FullName], [FacebookId], [FacebookLink], [RoleId], [StatusId]) VALUES (N'user1', N'123456', N'User 1', NULL, NULL, 2, 1)
INSERT [dbo].[Users] ([UserId], [Password], [FullName], [FacebookId], [FacebookLink], [RoleId], [StatusId]) VALUES (N'user2', N'123456', N'User 2', NULL, NULL, 2, 1)
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Discount] FOREIGN KEY([DiscountId])
REFERENCES [dbo].[Discount] ([DiscountId])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_Discount]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Status] ([StatusId])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_Status]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_Users]
GO
ALTER TABLE [dbo].[BookingDetail]  WITH CHECK ADD  CONSTRAINT [FK_BookingDetail_Booking] FOREIGN KEY([BookingId])
REFERENCES [dbo].[Booking] ([BookingId])
GO
ALTER TABLE [dbo].[BookingDetail] CHECK CONSTRAINT [FK_BookingDetail_Booking]
GO
ALTER TABLE [dbo].[BookingDetail]  WITH CHECK ADD  CONSTRAINT [FK_BookingDetail_Tour] FOREIGN KEY([TourId])
REFERENCES [dbo].[Tour] ([TourId])
GO
ALTER TABLE [dbo].[BookingDetail] CHECK CONSTRAINT [FK_BookingDetail_Tour]
GO
ALTER TABLE [dbo].[Tour]  WITH CHECK ADD  CONSTRAINT [FK_Tour_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Status] ([StatusId])
GO
ALTER TABLE [dbo].[Tour] CHECK CONSTRAINT [FK_Tour_Status]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([RoleId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Role]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Status] ([StatusId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Status]
GO
USE [master]
GO
ALTER DATABASE [DreamTraveling] SET  READ_WRITE 
GO
