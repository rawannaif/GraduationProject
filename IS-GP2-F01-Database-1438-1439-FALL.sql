USE [master]
GO
/****** Object:  Database [MCQ4U]    Script Date: 09/12/2017 7:17:28 PM ******/
CREATE DATABASE [MCQ4U]
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MCQ4U].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MCQ4U] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MCQ4U] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MCQ4U] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MCQ4U] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MCQ4U] SET ARITHABORT OFF 
GO
ALTER DATABASE [MCQ4U] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MCQ4U] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MCQ4U] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MCQ4U] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MCQ4U] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MCQ4U] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MCQ4U] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MCQ4U] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MCQ4U] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MCQ4U] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MCQ4U] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [MCQ4U] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MCQ4U] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [MCQ4U] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MCQ4U] SET  MULTI_USER 
GO
ALTER DATABASE [MCQ4U] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MCQ4U] SET ENCRYPTION ON
GO
ALTER DATABASE [MCQ4U] SET QUERY_STORE = ON
GO
ALTER DATABASE [MCQ4U] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 7), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 10, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO)
GO
USE [MCQ4U]
GO
/****** Object:  User [viewmcq]    Script Date: 09/12/2017 7:17:28 PM ******/
CREATE USER [viewmcq] FOR LOGIN [viewmcq] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [viewmcq]
GO
/****** Object:  UserDefinedTableType [dbo].[SurveyTable]    Script Date: 09/12/2017 7:17:29 PM ******/
CREATE TYPE [dbo].[SurveyTable] AS TABLE(
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CourseId] [int] NOT NULL,
	[StudentId] [int] NOT NULL,
	[StudentType] [int] NOT NULL,
	[DeadlineDate] [nvarchar](100) NULL,
	[LectureName] [nvarchar](100) NULL,
	[LectureNumber] [int] NULL
)
GO
/****** Object:  Table [dbo].[CoordinatorMessages]    Script Date: 09/12/2017 7:17:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CoordinatorMessages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[SurveyId] [int] NOT NULL
)

GO
/****** Object:  Table [dbo].[Courses]    Script Date: 09/12/2017 7:17:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CourseId] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[AdminId] [int] NOT NULL,
	[FacultyMemberId] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[SectionNumber] [int] NOT NULL,
	[NoOfLectures] [int] NOT NULL,
 CONSTRAINT [PK_Courses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Courses_Students]    Script Date: 09/12/2017 7:17:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses_Students](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CourseId] [int] NOT NULL,
	[StudentId] [int] NOT NULL,
	[AdminId] [int] NOT NULL,
 CONSTRAINT [PK_UsersCourses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 09/12/2017 7:17:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[Readed] [bit] NULL,
	[Type] [int] NOT NULL,
 CONSTRAINT [PK_Notifications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Questions]    Script Date: 09/12/2017 7:17:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Choice1] [nvarchar](100) NOT NULL,
	[Choice2] [nvarchar](100) NOT NULL,
	[Choice3] [nvarchar](100) NOT NULL,
	[Choice4] [nvarchar](100) NOT NULL,
	[RightChoice] [int] NOT NULL,
	[SurveyId] [int] NOT NULL,
	[StudentId] [int] NOT NULL,
 CONSTRAINT [PK_Questions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[StudentTypes]    Script Date: 09/12/2017 7:17:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
 CONSTRAINT [PK_StudentTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[SurveyAnswers]    Script Date: 09/12/2017 7:17:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyAnswers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SurveyId] [int] NOT NULL,
	[QuestionId] [int] NOT NULL,
	[QuestionAnswer] [int] NOT NULL,
	[StudentId] [int] NOT NULL
)

GO
/****** Object:  Table [dbo].[Surveys]    Script Date: 09/12/2017 7:17:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Surveys](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CourseId] [int] NOT NULL,
	[DeadlineDate] [nvarchar](100) NOT NULL,
	[LectureName] [nvarchar](100) NOT NULL,
	[LectureNumber] [int] NOT NULL,
	[SentToFacultyMember] [bit] NULL,
	[Approved] [bit] NULL,
 CONSTRAINT [PK_Surveys] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[SurveyUsers]    Script Date: 09/12/2017 7:17:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyUsers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SurveyId] [int] NOT NULL,
	[StudentId] [int] NOT NULL,
	[StudentType] [int] NOT NULL,
 CONSTRAINT [PK_SurveyUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Users]    Script Date: 09/12/2017 7:17:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[MiddleName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[UniversityNumber] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[UserType] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[Email] [nvarchar](100) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[UserTypes]    Script Date: 09/12/2017 7:17:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_UserTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET IDENTITY_INSERT [dbo].[CoordinatorMessages] ON 

INSERT [dbo].[CoordinatorMessages] ([Id], [Message], [SurveyId]) VALUES (24, N'hi', 30)
INSERT [dbo].[CoordinatorMessages] ([Id], [Message], [SurveyId]) VALUES (25, N'h', 32)
INSERT [dbo].[CoordinatorMessages] ([Id], [Message], [SurveyId]) VALUES (28, N'hello', 36)
INSERT [dbo].[CoordinatorMessages] ([Id], [Message], [SurveyId]) VALUES (29, N'please add question?', 37)
INSERT [dbo].[CoordinatorMessages] ([Id], [Message], [SurveyId]) VALUES (33, N'hello', 42)
INSERT [dbo].[CoordinatorMessages] ([Id], [Message], [SurveyId]) VALUES (36, N'hello', 46)
INSERT [dbo].[CoordinatorMessages] ([Id], [Message], [SurveyId]) VALUES (37, N'rahaf from slide 1-3
sara from slide 4-6
hala from slide 7-9
arwa from slide 10-12', 48)
INSERT [dbo].[CoordinatorMessages] ([Id], [Message], [SurveyId]) VALUES (38, N'rahaf from slide 1-5
sara from slide 6-10
hala from slide 11-15
arwa from slide 16-20', 49)
INSERT [dbo].[CoordinatorMessages] ([Id], [Message], [SurveyId]) VALUES (39, N'rahaf from slide 1-3
sara from slide 4-6
hala from slide 7-9
arwa from slide 10-12', 50)
INSERT [dbo].[CoordinatorMessages] ([Id], [Message], [SurveyId]) VALUES (41, N'Test', 53)
INSERT [dbo].[CoordinatorMessages] ([Id], [Message], [SurveyId]) VALUES (26, N'السلام عليكم', 34)
INSERT [dbo].[CoordinatorMessages] ([Id], [Message], [SurveyId]) VALUES (34, N'hello', 44)
INSERT [dbo].[CoordinatorMessages] ([Id], [Message], [SurveyId]) VALUES (35, N'hello', 45)
INSERT [dbo].[CoordinatorMessages] ([Id], [Message], [SurveyId]) VALUES (31, N'hello', 39)
INSERT [dbo].[CoordinatorMessages] ([Id], [Message], [SurveyId]) VALUES (32, N'jjjj', 40)
INSERT [dbo].[CoordinatorMessages] ([Id], [Message], [SurveyId]) VALUES (27, N'السلام عليكم', 35)
INSERT [dbo].[CoordinatorMessages] ([Id], [Message], [SurveyId]) VALUES (30, N'hi', 38)
INSERT [dbo].[CoordinatorMessages] ([Id], [Message], [SurveyId]) VALUES (40, N'hello', 51)
INSERT [dbo].[CoordinatorMessages] ([Id], [Message], [SurveyId]) VALUES (42, N'hello', 55)
SET IDENTITY_INSERT [dbo].[CoordinatorMessages] OFF
SET IDENTITY_INSERT [dbo].[Courses] ON 

INSERT [dbo].[Courses] ([Id], [CourseId], [Name], [AdminId], [FacultyMemberId], [CreationDate], [SectionNumber], [NoOfLectures]) VALUES (50, N'IS200', N'information system', 1, 23, CAST(N'2017-12-05T04:48:47.810' AS DateTime), 372, 12)
INSERT [dbo].[Courses] ([Id], [CourseId], [Name], [AdminId], [FacultyMemberId], [CreationDate], [SectionNumber], [NoOfLectures]) VALUES (51, N'395', N'ERP', 1, 7, CAST(N'2017-12-05T05:09:52.413' AS DateTime), 371, 2)
INSERT [dbo].[Courses] ([Id], [CourseId], [Name], [AdminId], [FacultyMemberId], [CreationDate], [SectionNumber], [NoOfLectures]) VALUES (54, N'123', N'database', 1, 7, CAST(N'2017-12-05T16:10:33.303' AS DateTime), 456, 100)
INSERT [dbo].[Courses] ([Id], [CourseId], [Name], [AdminId], [FacultyMemberId], [CreationDate], [SectionNumber], [NoOfLectures]) VALUES (55, N'IS372', N'Data Mining', 1, 27, CAST(N'2017-12-06T13:18:53.660' AS DateTime), 372, 20)
INSERT [dbo].[Courses] ([Id], [CourseId], [Name], [AdminId], [FacultyMemberId], [CreationDate], [SectionNumber], [NoOfLectures]) VALUES (61, N'IS379', N'E-Commerce', 1, 49, CAST(N'2017-12-07T12:58:01.063' AS DateTime), 373, 20)
INSERT [dbo].[Courses] ([Id], [CourseId], [Name], [AdminId], [FacultyMemberId], [CreationDate], [SectionNumber], [NoOfLectures]) VALUES (62, N'IS200', N'Information system', 1, 49, CAST(N'2017-12-07T19:14:50.280' AS DateTime), 374, 11)
INSERT [dbo].[Courses] ([Id], [CourseId], [Name], [AdminId], [FacultyMemberId], [CreationDate], [SectionNumber], [NoOfLectures]) VALUES (66, N'IS120', N'database', 1, 49, CAST(N'2017-12-07T22:24:32.133' AS DateTime), 372, 20)
SET IDENTITY_INSERT [dbo].[Courses] OFF
SET IDENTITY_INSERT [dbo].[Courses_Students] ON 

INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (209, 50, 9, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (210, 50, 10, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (211, 50, 22, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (212, 50, 14, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (213, 50, 15, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (214, 51, 14, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (215, 51, 10, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (216, 51, 9, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (217, 51, 22, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (218, 51, 15, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (219, 51, 16, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (220, 52, 28, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (221, 52, 29, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (222, 52, 30, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (223, 52, 31, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (224, 52, 32, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (225, 52, 22, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (226, 52, 34, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (227, 54, 9, 1)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (228, 54, 10, 1)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (229, 54, 16, 1)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (230, 54, 31, 1)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (231, 54, 35, 1)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (232, 54, 11, 1)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (233, 50, 28, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (234, 50, 29, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (235, 50, 30, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (236, 50, 31, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (237, 50, 32, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (238, 50, 33, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (239, 55, 28, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (240, 55, 29, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (241, 55, 30, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (242, 55, 31, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (243, 55, 32, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (244, 55, 33, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (245, 55, 11, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (246, 55, 22, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (247, 55, 15, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (248, 55, 9, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (249, 55, 41, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (250, 55, 14, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (251, 55, 34, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (252, 55, 35, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (253, 55, 38, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (254, 55, 36, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (255, 55, 42, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (256, 55, 13, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (257, 55, 19, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (258, 55, 20, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (259, 56, 47, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (260, 56, 46, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (261, 56, 48, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (262, 56, 43, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (263, 56, 44, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (264, 56, 45, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (265, 57, 43, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (266, 57, 44, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (267, 57, 45, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (268, 57, 46, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (269, 57, 47, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (270, 57, 48, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (271, 58, 43, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (272, 58, 44, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (273, 58, 45, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (274, 58, 46, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (275, 58, 47, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (276, 58, 48, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (277, 59, 43, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (278, 59, 44, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (279, 59, 45, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (280, 59, 46, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (281, 59, 47, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (282, 59, 48, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (283, 60, 43, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (284, 60, 44, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (285, 60, 45, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (286, 60, 46, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (287, 60, 47, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (288, 60, 48, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (289, 61, 43, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (290, 61, 44, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (291, 61, 45, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (292, 61, 46, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (293, 61, 47, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (294, 61, 48, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (295, 61, 57, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (296, 62, 50, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (297, 62, 55, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (298, 62, 54, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (299, 62, 52, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (300, 62, 51, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (301, 62, 43, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (302, 62, 57, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (303, 62, 45, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (304, 66, 43, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (305, 66, 44, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (306, 66, 46, 0)
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (307, 66, 47, 0)
GO
INSERT [dbo].[Courses_Students] ([Id], [CourseId], [StudentId], [AdminId]) VALUES (308, 66, 48, 0)
SET IDENTITY_INSERT [dbo].[Courses_Students] OFF
SET IDENTITY_INSERT [dbo].[Notifications] ON 

INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (135, 23, 50, 0, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (136, 9, 50, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (137, 10, 50, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (138, 14, 50, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (139, 15, 50, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (140, 22, 50, 1, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (141, 22, 50, 1, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (142, 9, 50, 1, 4)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (143, 22, 50, 1, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (144, 23, 50, 0, 6)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (145, 7, 51, 1, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (146, 10, 51, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (147, 9, 51, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (148, 22, 51, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (149, 16, 51, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (150, 14, 51, 0, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (151, 14, 51, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (152, 10, 51, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (153, 22, 51, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (154, 16, 51, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (155, 9, 51, 1, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (156, 14, 51, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (157, 10, 51, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (158, 9, 51, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (159, 22, 51, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (160, 16, 51, 0, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (161, 27, 52, 1, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (162, 37, 53, 0, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (163, 29, 52, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (164, 30, 52, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (165, 31, 52, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (166, 22, 52, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (167, 28, 52, 1, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (168, 29, 52, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (169, 30, 52, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (170, 31, 52, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (171, 22, 52, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (172, 28, 52, 1, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (173, 28, 52, 1, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (174, 27, 52, 1, 6)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (175, 28, 52, 1, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (176, 22, 52, 1, 4)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (177, 27, 52, 1, 6)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (178, 7, 54, 1, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (179, 29, 52, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (180, 30, 52, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (181, 31, 52, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (182, 32, 52, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (183, 28, 52, 1, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (184, 27, 52, 1, 6)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (185, 10, 54, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (186, 16, 54, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (187, 31, 54, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (188, 35, 54, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (189, 9, 54, 1, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (190, 28, 52, 1, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (191, 29, 52, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (192, 30, 52, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (193, 31, 52, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (194, 32, 52, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (195, 28, 52, 1, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (196, 9, 54, 1, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (197, 9, 54, 1, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (198, 10, 54, 1, 4)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (199, 9, 54, 1, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (200, 7, 54, 1, 6)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (201, 9, 54, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (202, 9, 54, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (203, 10, 54, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (204, 16, 54, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (205, 31, 54, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (206, 35, 54, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (207, 11, 54, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (208, 29, 52, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (209, 30, 52, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (210, 31, 52, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (211, 32, 52, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (212, 28, 52, 1, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (213, 28, 52, 1, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (214, 27, 52, 1, 6)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (215, 28, 52, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (216, 29, 52, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (217, 30, 52, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (218, 31, 52, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (219, 32, 52, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (220, 22, 52, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (221, 34, 52, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (222, 29, 52, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (223, 30, 52, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (224, 31, 52, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (225, 32, 52, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (226, 28, 52, 1, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (227, 28, 52, 1, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (228, 32, 52, 1, 4)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (229, 28, 52, 1, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (230, 27, 52, 1, 6)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (231, 28, 52, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (232, 29, 52, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (233, 30, 52, 0, 7)
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (234, 31, 52, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (235, 32, 52, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (236, 22, 52, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (237, 34, 52, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (238, 29, 52, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (239, 30, 52, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (240, 31, 52, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (241, 32, 52, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (242, 28, 52, 0, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (243, 27, 55, 1, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (244, 29, 55, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (245, 30, 55, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (246, 31, 55, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (247, 32, 55, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (248, 28, 55, 1, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (249, 28, 55, 1, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (250, 28, 55, 1, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (251, 30, 55, 1, 4)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (252, 27, 55, 1, 6)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (253, 28, 55, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (254, 29, 55, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (255, 30, 55, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (256, 31, 55, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (257, 32, 55, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (258, 33, 55, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (259, 11, 55, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (260, 22, 55, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (261, 15, 55, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (262, 9, 55, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (263, 41, 55, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (264, 14, 55, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (265, 34, 55, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (266, 35, 55, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (267, 38, 55, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (268, 36, 55, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (269, 42, 55, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (270, 13, 55, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (271, 19, 55, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (272, 20, 55, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (273, 29, 55, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (274, 30, 55, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (275, 31, 55, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (276, 32, 55, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (277, 28, 55, 1, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (278, 49, 56, 1, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (279, 47, 56, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (280, 46, 56, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (281, 44, 56, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (282, 45, 56, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (283, 43, 56, 1, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (284, 43, 56, 1, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (285, 49, 56, 1, 6)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (286, 47, 56, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (287, 46, 56, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (288, 48, 56, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (289, 43, 56, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (290, 44, 56, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (291, 45, 56, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (292, 47, 56, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (293, 46, 56, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (294, 44, 56, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (295, 45, 56, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (296, 43, 56, 1, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (297, 43, 56, 1, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (298, 56, 57, 1, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (299, 44, 57, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (300, 45, 57, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (301, 46, 57, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (302, 47, 57, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (303, 43, 57, 1, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (304, 43, 57, 1, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (305, 49, 58, 1, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (306, 44, 58, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (307, 45, 58, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (308, 46, 58, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (309, 47, 58, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (310, 43, 58, 1, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (311, 49, 58, 1, 6)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (312, 56, 57, 1, 6)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (313, 43, 57, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (314, 44, 57, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (315, 45, 57, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (316, 46, 57, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (317, 47, 57, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (318, 48, 57, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (319, 49, 59, 1, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (320, 49, 60, 1, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (321, 44, 60, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (322, 45, 60, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (323, 46, 60, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (324, 47, 60, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (325, 43, 60, 1, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (326, 43, 60, 1, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (327, 49, 60, 1, 6)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (328, 43, 60, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (329, 44, 60, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (330, 45, 60, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (331, 46, 60, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (332, 47, 60, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (333, 48, 60, 1, 7)
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (334, 44, 60, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (335, 45, 60, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (336, 46, 60, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (337, 47, 60, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (338, 43, 60, 1, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (339, 43, 60, 1, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (340, 45, 60, 1, 4)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (341, 43, 60, 1, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (342, 49, 60, 1, 6)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (343, 43, 60, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (344, 44, 60, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (345, 45, 60, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (346, 46, 60, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (347, 47, 60, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (348, 48, 60, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (349, 49, 61, 1, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (350, 44, 61, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (351, 45, 61, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (352, 46, 61, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (353, 47, 61, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (354, 43, 61, 1, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (355, 44, 61, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (356, 45, 61, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (357, 46, 61, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (358, 47, 61, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (359, 43, 61, 1, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (360, 44, 61, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (361, 45, 61, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (362, 46, 61, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (363, 47, 61, 1, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (364, 43, 61, 1, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (365, 43, 61, 1, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (366, 49, 61, 1, 6)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (367, 43, 61, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (368, 44, 61, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (369, 45, 61, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (370, 46, 61, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (371, 47, 61, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (372, 48, 61, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (373, 43, 61, 1, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (374, 49, 61, 1, 6)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (375, 43, 61, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (376, 44, 61, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (377, 45, 61, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (378, 46, 61, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (379, 47, 61, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (380, 48, 61, 1, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (381, 49, 62, 0, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (382, 49, 63, 0, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (383, 56, 64, 0, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (384, 49, 65, 0, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (385, 55, 62, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (386, 54, 62, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (387, 52, 62, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (388, 51, 62, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (389, 50, 62, 0, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (390, 50, 62, 0, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (391, 52, 62, 0, 4)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (392, 50, 62, 0, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (393, 49, 62, 0, 6)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (394, 50, 62, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (395, 55, 62, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (396, 54, 62, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (397, 52, 62, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (398, 51, 62, 0, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (399, 50, 62, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (400, 55, 62, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (401, 54, 62, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (402, 52, 62, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (403, 51, 62, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (404, 43, 62, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (405, 57, 62, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (406, 45, 62, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (407, 49, 66, 0, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (408, 44, 66, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (409, 46, 66, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (410, 47, 66, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (411, 48, 66, 0, 3)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (412, 43, 66, 0, 2)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (413, 43, 66, 0, 5)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (414, 49, 66, 0, 6)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (415, 43, 66, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (416, 44, 66, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (417, 46, 66, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (418, 47, 66, 0, 7)
INSERT [dbo].[Notifications] ([Id], [UserId], [CourseId], [Readed], [Type]) VALUES (419, 48, 66, 0, 7)
SET IDENTITY_INSERT [dbo].[Notifications] OFF
SET IDENTITY_INSERT [dbo].[Questions] ON 

INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (82, N'test', N'test', N'test', N'test', N'test', 1, 30, 10)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (84, N'y', N'7', N'7', N'7', N'7', 4, 30, 14)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (85, N'ggh', N'ffj', N'bv', N'fgj', N'cv', 1, 30, 15)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (86, N'jjhg', N'ccvb', N'vvb', N'ghu', N'ggg', 1, 30, 9)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (87, N'j', N'jk', N'h', N'h', N'j', 1, 32, 10)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (88, N'nnn', N'nbb', N'hhh', N'hhh', N'jjj', 1, 34, 22)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (90, N'color', N'blue', N'y', N't', N'g', 1, 34, 29)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (91, N'shape', N'square', N'y', N'b', N'g', 1, 34, 30)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (92, N'color', N'red', N'y', N'i', N's', 1, 34, 31)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (93, N'colour', N'red', N't', N'b', N'y', 1, 35, 29)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (94, N'shape', N'square', N'6', N'g', N'f', 1, 35, 30)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (95, N'sara', N's', N'y', N'u', N'b', 1, 35, 31)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (96, N'g', N'1', N'2', N'3', N'4', 1, 36, 29)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (97, N'b', N'1', N'2', N'3', N'4', 1, 36, 30)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (98, N'h', N'4', N'6', N'3', N'6', 1, 36, 31)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (99, N'hhh', N'1', N'2', N'3', N'4', 1, 36, 32)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (101, N'question two?', N's', N's', N's', N's', 2, 37, 16)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (102, N'question three?', N'H', N'h', N'h', N'h', 3, 37, 31)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (104, N'question four?', N'h', N'h', N'h', N'h', 4, 37, 35)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (105, N'question four?', N'd', N'd', N'd', N'd', 4, 37, 10)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (106, N'h', N'q', N'2', N'4', N't', 1, 39, 29)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (107, N'h', N'5', N'5', N'7', N'6', 1, 39, 30)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (108, N'ucuf', N'4', N'5', N'7', N'8', 1, 39, 31)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (109, N'ufu', N'r', N'g', N'g', N'g', 1, 39, 32)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (110, N'gkffi', N'b', N'f', N'g', N'g', 1, 40, 29)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (111, N'gcf', N'h', N'g', N'j', N'n', 1, 40, 30)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (112, N'sfhffhj', N'6', N'8', N'7', N'7', 1, 40, 31)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (114, N'hhh', N'k', N'0', N'9', N'8', 1, 40, 32)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (115, N'h', N'1', N'1', N'2', N'4', 1, 42, 29)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (116, N'ttt', N'1', N'2', N'3', N'4', 1, 42, 30)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (118, N'hell', N'2', N'6', N'0', N'8', 1, 42, 31)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (119, N'hhh', N'6', N'8', N'9', N'0', 1, 42, 32)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (120, N'no', N'1', N'2', N'3', N'4', 1, 44, 44)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (121, N'mm', N'1', N'2', N'3', N'4', 1, 44, 45)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (122, N'hhh', N'1', N'2', N'3', N'4', 1, 44, 46)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (123, N'hmm', N'7', N'8', N'9', N'0', 1, 44, 47)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (124, N'mi', N'4', N'6', N'8', N'9', 1, 45, 44)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (125, N'jjj', N'6', N'8', N'9', N'0.', 1, 45, 45)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (126, N'fff', N'8', N'7', N'0', N'5', 1, 45, 46)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (127, N'uu', N'7', N'8', N'9', N'0', 1, 45, 47)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (128, N'he', N'8', N'9', N'0', N'9', 1, 46, 44)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (129, N'uh', N'8', N'0', N'9', N'9', 1, 46, 45)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (130, N'yg', N'9', N'0', N'7', N'8', 1, 46, 46)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (131, N'hi', N'8', N'9', N'0', N'0', 1, 46, 47)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (132, N'.................the process of buying, selling, or exchanging products, services, or information vi', N'EC', N'IT', N'ERP', N'DM', 1, 48, 44)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (133, N'brik-and-mortar, pure play, click-and-mortar is consider as ...........', N'EC transactions', N'EC organisations', N'all of above', N'non of above', 2, 48, 45)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (134, N'EC transactions includes', N'B2B', N'B2C', N'C2C', N'all of above', 4, 48, 46)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (135, N'wikis, RSS, blogs, microblogs are ............', N'EC tools', N'security tools', N'Web 2.0 tools', N'non of above', 3, 48, 47)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (136, N'an online market, usually B2B, in which sellers exchange goods or services', N'e-marketplace', N'marketplace', N'mall', N'all of above', 1, 49, 44)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (138, N'storefronts, malls, portals are', N'customer shopping mechanisms', N'merchant solutions', N'EC transactions', N'non of above', 1, 49, 46)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (139, N'merchant solutions is', N'search engines', N'electronic catalogs', N'shopping carts', N'all of above', 4, 49, 47)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (140, N'types of portals', N'personal', N'publishing', N'mobile', N'all of above', 4, 49, 45)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (141, N'..................the process of buying, selling, or exchanging products, services, or information v', N'EC', N'IT', N'ERP', N'DM', 1, 50, 44)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (142, N'brik-and-mortar, pure-play, click-and-mortar are consider as', N'EC transactions', N'EC organisations', N'all of above', N'non of above', 2, 50, 45)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (143, N'EC transactions are', N'B2B', N'B2C', N'C2C', N'all of above', 4, 50, 46)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (144, N'wikis, RSS, blogs, microblogs are ............', N'EC tools', N'security tools', N'Web 2.0 tools', N'non of above', 3, 50, 47)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (145, N'hgg', N'j', N'k', N'k', N'g', 1, 51, 44)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (146, N'uh', N'l', N'n', N'j', N'k', 1, 51, 45)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (147, N'hgv', N'k', N'j', N'k', N'j', 1, 51, 46)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (148, N'gffh', N'k', N'j', N'k', N'k', 1, 51, 47)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (150, N'number 2', N'y', N'true', N'5', N'7', 2, 53, 55)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (151, N'three', N'y', N'y', N'y', N'j', 3, 53, 51)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (152, N'foure', N'b', N'h', N'h', N'g', 4, 53, 54)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (153, N'one', N'y', N'h', N'h', N'y', 1, 53, 52)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (154, N'hgg
j', N'9', N'7', N'9', N'j', 1, 55, 44)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (155, N'bddd', N'i', N'b', N'j', N'k', 1, 55, 46)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (156, N'ggfg', N'8', N'8', N'7', N'7', 1, 55, 47)
INSERT [dbo].[Questions] ([Id], [Title], [Choice1], [Choice2], [Choice3], [Choice4], [RightChoice], [SurveyId], [StudentId]) VALUES (157, N'fssd', N'j', N'g', N'h', N'j', 1, 55, 48)
SET IDENTITY_INSERT [dbo].[Questions] OFF
SET IDENTITY_INSERT [dbo].[StudentTypes] ON 

INSERT [dbo].[StudentTypes] ([Id], [Name]) VALUES (1, N'Coordinator')
INSERT [dbo].[StudentTypes] ([Id], [Name]) VALUES (2, N'Student')
SET IDENTITY_INSERT [dbo].[StudentTypes] OFF
SET IDENTITY_INSERT [dbo].[SurveyAnswers] ON 

INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (145, 34, 88, 1, 22)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (146, 34, 90, -1, 22)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (148, 34, 92, -1, 22)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (149, 34, 88, -1, 28)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (150, 34, 90, 1, 28)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (151, 34, 91, -1, 28)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (152, 34, 92, 1, 28)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (153, 34, 88, 1, 29)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (154, 34, 90, -1, 29)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (155, 34, 91, -1, 29)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (156, 34, 92, 1, 29)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (169, 37, 101, -1, 35)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (170, 37, 102, -1, 35)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (171, 37, 104, -1, 35)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (172, 37, 105, -1, 35)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (173, 37, 101, 1, 31)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (174, 37, 102, -1, 31)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (175, 37, 104, -1, 31)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (176, 37, 105, -1, 31)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (177, 44, 120, 1, 43)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (178, 44, 121, -1, 43)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (179, 44, 122, -1, 43)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (180, 44, 123, -1, 43)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (181, 48, 132, 1, 43)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (182, 48, 133, 1, 43)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (183, 48, 134, 1, 43)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (184, 48, 135, 1, 43)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (185, 48, 132, -1, 45)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (186, 48, 133, -1, 45)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (187, 48, 134, 1, 45)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (188, 48, 135, 1, 45)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (193, 48, 132, -1, 46)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (194, 48, 133, -1, 46)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (196, 48, 135, -1, 46)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (197, 48, 132, 1, 47)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (198, 48, 133, 1, 47)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (199, 48, 134, 1, 47)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (200, 48, 135, 1, 47)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (213, 50, 141, -1, 45)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (214, 50, 142, -1, 45)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (215, 50, 143, -1, 45)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (216, 50, 144, -1, 45)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (229, 53, 150, -1, 43)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (230, 53, 151, -1, 43)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (231, 53, 152, -1, 43)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (232, 53, 153, -1, 43)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (147, 34, 91, 1, 22)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (195, 48, 134, -1, 46)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (157, 34, 88, 1, 30)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (158, 34, 90, 1, 30)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (159, 34, 91, 1, 30)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (160, 34, 92, 1, 30)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (161, 37, 101, 1, 10)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (162, 37, 102, 1, 10)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (163, 37, 104, 1, 10)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (164, 37, 105, 1, 10)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (165, 37, 101, -1, 9)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (166, 37, 102, -1, 9)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (167, 37, 104, -1, 9)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (168, 37, 105, -1, 9)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (189, 48, 132, 1, 44)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (190, 48, 133, -1, 44)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (191, 48, 134, -1, 44)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (192, 48, 135, -1, 44)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (201, 50, 141, 1, 46)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (202, 50, 142, 1, 46)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (203, 50, 143, 1, 46)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (204, 50, 144, 1, 46)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (205, 50, 141, -1, 43)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (206, 50, 142, -1, 43)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (207, 50, 143, -1, 43)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (208, 50, 144, -1, 43)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (217, 50, 141, 1, 47)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (218, 50, 142, 1, 47)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (219, 50, 143, 1, 47)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (220, 50, 144, 1, 47)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (221, 50, 141, 1, 48)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (222, 50, 142, -1, 48)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (223, 50, 143, -1, 48)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (224, 50, 144, -1, 48)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (225, 51, 145, -1, 48)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (226, 51, 146, -1, 48)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (227, 51, 147, -1, 48)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (228, 51, 148, -1, 48)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (233, 53, 150, -1, 50)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (234, 53, 151, -1, 50)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (235, 53, 152, 1, 50)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (236, 53, 153, 1, 50)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (237, 53, 150, -1, 52)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (238, 53, 151, -1, 52)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (239, 53, 152, -1, 52)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (240, 53, 153, -1, 52)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (209, 50, 141, 1, 44)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (210, 50, 142, -1, 44)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (211, 50, 143, 1, 44)
INSERT [dbo].[SurveyAnswers] ([Id], [SurveyId], [QuestionId], [QuestionAnswer], [StudentId]) VALUES (212, 50, 144, -1, 44)
SET IDENTITY_INSERT [dbo].[SurveyAnswers] OFF
SET IDENTITY_INSERT [dbo].[Surveys] ON 

INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (30, 50, N'2017-12-7', N'interduction', 1, 1, NULL)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (31, 51, N'2017-12-6', N'test', 1, 0, NULL)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (32, 51, N'2017-12-26', N'tt', 2, 0, NULL)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (33, 51, N'2017-12-18', N'ttest', 2, 0, NULL)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (34, 52, N'2017-12-6', N'chapter1', 1, 1, 1)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (35, 52, N'2017-12-6', N'chapter1', 1, 1, 1)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (36, 52, N'2017-12-8', N'chapter 2', 2, 1, NULL)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (37, 54, N'2017-12-7', N'introduction to database', 50, 1, 1)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (38, 52, N'2017-12-15', N'chapter 3', 20, 0, NULL)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (39, 52, N'2017-12-7', N'chapter 3', 3, 1, 1)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (40, 52, N'2017-12-22', N'chp5', 5, 1, 1)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (41, 52, N'2017-12-16', N'jhv', 1, 0, NULL)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (42, 55, N'2017-12-15', N'chapter 1: introduction', 1, 1, 1)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (43, 55, N'2017-12-23', N'chapter 2', 2, 0, NULL)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (44, 56, N'2017-12-30', N'chapter 1', 1, 1, 1)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (45, 56, N'2017-12-22', N'chapter 2', 2, 0, NULL)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (46, 57, N'2017-12-21', N'introduction to database', 1, 1, 1)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (47, 58, N'2017-12-22', N'IT', 1, 1, NULL)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (48, 60, N'2017-12-8', N'chapter1:introduction to EC', 1, 1, 1)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (49, 60, N'2017-12-15', N'chapter 2', 2, 1, 1)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (50, 61, N'2017-12-8', N'chapter1: introduction to EC', 1, 1, 1)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (51, 61, N'2017-12-10', N'chapter2: ec infrastructures', 2, 1, 1)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (52, 61, N'2017-12-12', N'chapter3: products and service', 3, 0, NULL)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (53, 62, N'2017-12-9', N'interduction', 1, 1, 1)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (54, 62, N'2017-12-8', N't', 2, 0, NULL)
INSERT [dbo].[Surveys] ([Id], [CourseId], [DeadlineDate], [LectureName], [LectureNumber], [SentToFacultyMember], [Approved]) VALUES (55, 66, N'2017-12-22', N'chapter', 1, 1, 1)
SET IDENTITY_INSERT [dbo].[Surveys] OFF
SET IDENTITY_INSERT [dbo].[SurveyUsers] ON 

INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (156, 30, 9, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (157, 30, 10, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (158, 30, 14, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (159, 30, 15, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (160, 30, 22, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (161, 31, 10, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (162, 31, 9, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (163, 31, 22, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (164, 31, 16, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (165, 31, 14, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (166, 32, 14, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (167, 32, 10, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (168, 32, 22, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (169, 32, 16, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (170, 32, 9, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (171, 33, 14, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (172, 33, 10, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (173, 33, 9, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (174, 33, 22, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (175, 33, 16, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (176, 34, 29, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (177, 34, 30, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (178, 34, 31, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (179, 34, 22, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (180, 34, 28, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (181, 35, 29, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (182, 35, 30, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (183, 35, 31, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (184, 35, 22, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (185, 35, 28, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (186, 36, 29, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (187, 36, 30, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (188, 36, 31, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (189, 36, 32, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (190, 36, 28, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (191, 37, 10, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (192, 37, 16, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (193, 37, 31, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (194, 37, 35, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (195, 37, 9, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (196, 38, 29, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (197, 38, 30, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (198, 38, 31, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (199, 38, 32, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (200, 38, 28, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (201, 39, 29, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (202, 39, 30, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (203, 39, 31, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (204, 39, 32, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (205, 39, 28, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (206, 40, 29, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (207, 40, 30, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (208, 40, 31, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (209, 40, 32, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (210, 40, 28, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (211, 41, 29, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (212, 41, 30, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (213, 41, 31, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (214, 41, 32, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (215, 41, 28, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (216, 42, 29, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (217, 42, 30, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (218, 42, 31, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (219, 42, 32, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (220, 42, 28, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (221, 43, 29, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (222, 43, 30, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (223, 43, 31, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (224, 43, 32, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (225, 43, 28, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (226, 44, 47, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (227, 44, 46, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (228, 44, 44, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (229, 44, 45, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (230, 44, 43, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (231, 45, 47, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (232, 45, 46, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (233, 45, 44, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (234, 45, 45, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (235, 45, 43, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (236, 46, 44, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (237, 46, 45, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (238, 46, 46, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (239, 46, 47, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (240, 46, 43, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (241, 47, 44, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (242, 47, 45, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (243, 47, 46, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (244, 47, 47, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (245, 47, 43, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (246, 48, 44, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (247, 48, 45, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (248, 48, 46, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (249, 48, 47, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (250, 48, 43, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (251, 49, 44, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (252, 49, 45, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (253, 49, 46, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (254, 49, 47, 2)
GO
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (255, 49, 43, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (256, 50, 44, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (257, 50, 45, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (258, 50, 46, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (259, 50, 47, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (260, 50, 43, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (261, 51, 44, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (262, 51, 45, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (263, 51, 46, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (264, 51, 47, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (265, 51, 43, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (266, 52, 44, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (267, 52, 45, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (268, 52, 46, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (269, 52, 47, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (270, 52, 43, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (271, 53, 55, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (272, 53, 54, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (273, 53, 52, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (274, 53, 51, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (275, 53, 50, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (276, 54, 50, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (277, 54, 55, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (278, 54, 54, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (279, 54, 52, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (280, 54, 51, 1)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (281, 55, 44, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (282, 55, 46, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (283, 55, 47, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (284, 55, 48, 2)
INSERT [dbo].[SurveyUsers] ([Id], [SurveyId], [StudentId], [StudentType]) VALUES (285, 55, 43, 1)
SET IDENTITY_INSERT [dbo].[SurveyUsers] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [FirstName], [MiddleName], [LastName], [UniversityNumber], [Password], [UserType], [CreationDate], [Email]) VALUES (1, N'admin', N'admin', N'admin', N'111111111', N'test1234', 1, CAST(N'2017-10-29T20:24:11.967' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [MiddleName], [LastName], [UniversityNumber], [Password], [UserType], [CreationDate], [Email]) VALUES (43, N'Nourah', N'salem', N'albarqi', N'434025371', N'n1234', 3, CAST(N'2017-12-06T14:30:30.490' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [MiddleName], [LastName], [UniversityNumber], [Password], [UserType], [CreationDate], [Email]) VALUES (44, N'rahaf', N'ali', N'alahmari', N'434025372', N'r1234', 3, CAST(N'2017-12-06T14:31:07.770' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [MiddleName], [LastName], [UniversityNumber], [Password], [UserType], [CreationDate], [Email]) VALUES (46, N'hala', N'ahmed', N'alqarni', N'434025374', N'h1234', 3, CAST(N'2017-12-06T14:32:28.160' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [MiddleName], [LastName], [UniversityNumber], [Password], [UserType], [CreationDate], [Email]) VALUES (47, N'arwa', N'Ibrahim', N'alhweshl', N'434025375', N'a1234', 3, CAST(N'2017-12-06T14:33:01.817' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [MiddleName], [LastName], [UniversityNumber], [Password], [UserType], [CreationDate], [Email]) VALUES (48, N'jana', N'mohamed', N'alsafi', N'434025376', N'j1234', 3, CAST(N'2017-12-06T14:34:04.003' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [MiddleName], [LastName], [UniversityNumber], [Password], [UserType], [CreationDate], [Email]) VALUES (49, N'Amal', N'Ahmed', N'alsunadi', N'123456789', N'a1234', 2, CAST(N'2017-12-06T14:35:03.990' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [MiddleName], [LastName], [UniversityNumber], [Password], [UserType], [CreationDate], [Email]) VALUES (50, N'Nowair', N'Nasser', N'Alotaibi', N'434026077', N'123456', 3, CAST(N'2017-12-06T14:53:39.113' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [MiddleName], [LastName], [UniversityNumber], [Password], [UserType], [CreationDate], [Email]) VALUES (52, N'Alanoud', N'Saoud', N'Fahad', N'434026075', N'123456', 3, CAST(N'2017-12-06T14:56:32.740' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [MiddleName], [LastName], [UniversityNumber], [Password], [UserType], [CreationDate], [Email]) VALUES (54, N'Wejdan', N'Bader', N'Ahmad', N'434026073', N'123456', 3, CAST(N'2017-12-06T15:00:16.600' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [MiddleName], [LastName], [UniversityNumber], [Password], [UserType], [CreationDate], [Email]) VALUES (55, N'Ragad', N'Majed', N'Abdullah', N'434026072', N'123456', 3, CAST(N'2017-12-06T15:02:13.427' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [MiddleName], [LastName], [UniversityNumber], [Password], [UserType], [CreationDate], [Email]) VALUES (56, N'asma', N'mohamed', N'alasmary', N'123456780', N'a1234', 2, CAST(N'2017-12-06T15:23:52.943' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [MiddleName], [LastName], [UniversityNumber], [Password], [UserType], [CreationDate], [Email]) VALUES (57, N'Abrar', N'ali', N'alalyani', N'434025159', N'a1234', 3, CAST(N'2017-12-07T11:03:07.150' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [MiddleName], [LastName], [UniversityNumber], [Password], [UserType], [CreationDate], [Email]) VALUES (58, N'Boshra', N'mohamed', N'alali', N'966123584', N'b1234', 2, CAST(N'2017-12-07T11:04:01.340' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
SET IDENTITY_INSERT [dbo].[UserTypes] ON 

INSERT [dbo].[UserTypes] ([Id], [Name]) VALUES (1, N'Admin')
INSERT [dbo].[UserTypes] ([Id], [Name]) VALUES (2, N'Faculty Member')
INSERT [dbo].[UserTypes] ([Id], [Name]) VALUES (3, N'Student')
SET IDENTITY_INSERT [dbo].[UserTypes] OFF
/****** Object:  StoredProcedure [dbo].[AddCourse]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddCourse] 

 @Id int output
,@AdminId int
,@Name nvarchar(100)
,@NoOfLectures int
,@FacultyMemberId int
,@SectionNumber int
,@CourseId  nvarchar(50)

AS
BEGIN

SET NOCOUNT ON;

IF EXISTS(SELECT Id
          FROM [dbo].[Courses] 
          where [Name] = @Name and [SectionNumber] = @SectionNumber)
BEGIN
set @Id = -1
END
ELSE
BEGIN
INSERT INTO [dbo].[Courses]
           ([CourseId]
           ,[Name]
           ,[AdminId]
           ,[FacultyMemberId]
           ,[CreationDate]
           ,[SectionNumber]
           ,[NoOfLectures])
     VALUES
           (@CourseId
           ,@Name
           ,@AdminId
           ,@FacultyMemberId
           ,GETDATE()
           ,@SectionNumber
           ,@NoOfLectures)


set @Id = SCOPE_IDENTITY()
END

END
GO
/****** Object:  StoredProcedure [dbo].[AddNotification]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddNotification] 

 @Id int output
,@UserId int
,@Type int
,@CourseId  nvarchar(50)

AS
BEGIN

SET NOCOUNT ON;

INSERT INTO [dbo].[Notifications]
           ([UserId]
           ,[CourseId]
           ,[Readed]
           ,[Type])
     VALUES
           (@UserId
           ,@CourseId
           ,0
           ,@Type)


set @Id = SCOPE_IDENTITY()
END


GO
/****** Object:  StoredProcedure [dbo].[AnswerSurvey]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AnswerSurvey] 

@Id int output
,@SurveyId int
,@QuestionId int
,@StudentId int
,@QuestionAnswer int
           
AS
BEGIN

SET NOCOUNT ON;

INSERT INTO [MCQ4U].[dbo].[SurveyAnswers]
           ([SurveyId]
           ,[QuestionId]
           ,[QuestionAnswer]
           ,[StudentId])
     VALUES
           (@SurveyId
           ,@QuestionId
           ,@QuestionAnswer
           ,@StudentId)

set @Id = SCOPE_IDENTITY()
END


GO
/****** Object:  StoredProcedure [dbo].[CoordinatorMessagesAdd]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[CoordinatorMessagesAdd] 

@Id int output
,@SurveyId int
,@Message nvarchar(max)
           
AS
BEGIN

SET NOCOUNT ON;

INSERT INTO [dbo].[CoordinatorMessages]
           ([Message]
           ,[SurveyId])
     VALUES
           (@Message
           ,@SurveyId)

set @Id = SCOPE_IDENTITY()
END


GO
/****** Object:  StoredProcedure [dbo].[Course_Delete]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[Course_Delete] 

@Id int
AS
BEGIN

SET NOCOUNT ON;

Delete FROM [dbo].[Courses] WHERE Id = @Id

END

GO
/****** Object:  StoredProcedure [dbo].[Courses_StudentsAdd]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Courses_StudentsAdd] 

@Id int output
,@CourseId int
,@StudentId int
,@AdminId int
           
AS
BEGIN

SET NOCOUNT ON;

IF EXISTS(SELECT Id
          FROM [dbo].[Courses_Students]
          where [CourseId] = @CourseId and [StudentId] =@StudentId)
BEGIN
set @Id = -1
END

ELSE IF EXISTS(
SELECT [Courses].[Id] FROM [dbo].[Courses_Students]
Inner JOIN [Courses] on [Courses].[Id] = [Courses_Students].[CourseId]
where [Courses_Students].[StudentId] = @StudentId
and [Courses].[Name] in (select [Name] From [Courses] where [Id] = @CourseId)
)
BEGIN
set @Id = -2
END

ELSE
BEGIN
INSERT INTO [dbo].[Courses_Students]
           (  [CourseId]
      ,[StudentId]
      ,[AdminId])
     VALUES
           (@CourseId,
           @StudentId,
           @AdminId)

set @Id = SCOPE_IDENTITY()
END

END
GO
/****** Object:  StoredProcedure [dbo].[GetAllAdminCourses]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllAdminCourses]

@adminId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Courses].[Id]
      ,[Courses].[Name]
      ,[Courses].[CourseId]
      ,[Courses].[AdminId]
      ,[Courses].[FacultyMemberId]
      ,[Courses].[CreationDate]
      ,[Courses].[SectionNumber]
      ,[Courses].[NoOfLectures]
      , Users.FirstName AS AdminFirstName
      , Users.LastName AS AdminLastName
      , Users.MiddleName AS AdminMiddleName
      , Users.Email AS AdminEmail
      , Users_1.FirstName AS FacultyMemberFirstName
      , Users_1.LastName AS FacultyMemberLastName
      , Users_1.MiddleName AS FacultyMemberMiddleName
      , Users_1.UniversityNumber AS FacultyUniversityNumber
      , Users_1.Email AS FacultyMemberEmail
  FROM [dbo].[Courses]
  INNER JOIN Users ON [Courses].[AdminId] = [Users].[Id] 
  INNER JOIN Users AS Users_1 ON [Courses].[FacultyMemberId] = Users_1.Id
  where [Courses].[AdminId] = @adminId

END


/****** Object:  StoredProcedure [dbo].[GetAllCoordinatorCourses]    Script Date: 10/27/2017 13:31:14 ******/
SET ANSI_NULLS ON

GO
/****** Object:  StoredProcedure [dbo].[GetAllCoordinatorCourses]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllCoordinatorCourses]

@StudentId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Courses].[Id]
		,[Courses].[CourseId]
      ,[Courses].[Name]
      ,[Courses].[AdminId]
      ,[Courses].[FacultyMemberId]
      ,[Courses].[CreationDate]
      ,[Courses].[SectionNumber]
      ,[Courses].[NoOfLectures]
      , Users.FirstName AS AdminFirstName
      , Users.LastName AS AdminLastName
      , Users.MiddleName AS AdminMiddleName
      , Users.Email AS AdminEmail
      , Users_1.FirstName AS FacultyMemberFirstName
      , Users_1.LastName AS FacultyMemberLastName
      , Users_1.MiddleName AS FacultyMemberMiddleName
      , Users_1.Email AS FacultyMemberEmail
  FROM [dbo].[Courses]
  INNER JOIN Users ON [Courses].[AdminId] = [Users].[Id] 
  INNER JOIN Users AS Users_1 ON [Courses].[FacultyMemberId] = Users_1.Id
  
where [Courses].[Id] in (
select [Surveys].[CourseId] from SurveyUsers 
INNER JOIN Surveys ON [SurveyUsers].[SurveyId] = [Surveys].[Id] 
where SurveyUsers.StudentId = @StudentId
and SurveyUsers.StudentType = '1')

END

GO
/****** Object:  StoredProcedure [dbo].[GetAllCoordinatorSurveys]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[GetAllCoordinatorSurveys] 

@CourseId int
,@StudentId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


SELECT [Surveys].[Id]
      ,[Surveys].[CourseId]
      ,[Surveys].[DeadlineDate]
      ,[Surveys].[LectureName]
      ,[Surveys].[LectureNumber]
      ,[Surveys].[SentToFacultyMember]
      ,[Surveys].[Approved]
  FROM [dbo].[Surveys]
inner join SurveyUsers on SurveyUsers.[SurveyId] = [Surveys].[Id]
  where [Surveys].[CourseId] = @CourseId 
  and SurveyUsers.StudentId = @StudentId
  and SurveyUsers.StudentType = 1
  
END

GO
/****** Object:  StoredProcedure [dbo].[GetAllCourses]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllCourses]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Courses].[Id]
      ,[Courses].[Name]
      ,[Courses].[CourseId]
      ,[Courses].[AdminId]
      ,[Courses].[FacultyMemberId]
      ,[Courses].[CreationDate]
      ,[Courses].[SectionNumber]
      ,[Courses].[NoOfLectures]
      , Users.FirstName AS AdminFirstName
      , Users.LastName AS AdminLastName
      , Users.MiddleName AS AdminMiddleName
      , Users.Email AS AdminEmail
      , Users_1.FirstName AS FacultyMemberFirstName
      , Users_1.LastName AS FacultyMemberLastName
      , Users_1.MiddleName AS FacultyMemberMiddleName
      , Users_1.Email AS FacultyMemberEmail
             ,Surveys.[SentToFacultyMember]
      ,Surveys.[Approved]
  FROM [dbo].[Courses]
  INNER JOIN Users ON [Courses].[AdminId] = [Users].[Id] 
  INNER JOIN Users AS Users_1 ON [Courses].[FacultyMemberId] = Users_1.Id
  left outer JOIN Surveys ON [Courses].[Id] = [Surveys].[CourseId] 
  
END

GO
/****** Object:  StoredProcedure [dbo].[GetAllFacultyMembers]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[GetAllFacultyMembers]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from Users where UserType = '2'
END

GO
/****** Object:  StoredProcedure [dbo].[GetAllFacultyMemberStatistics]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllFacultyMemberStatistics]

@StudentId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


SELECT [Courses].[Id]
	,[Courses].[CourseId]
      ,[Courses].[Name]
      ,[Courses].[AdminId]
      ,[Courses].[FacultyMemberId]
      ,[Courses].[CreationDate]
      ,[Courses].[SectionNumber]
      ,[Courses].[NoOfLectures]
      , Users.FirstName AS AdminFirstName
      , Users.LastName AS AdminLastName
      , Users.MiddleName AS AdminMiddleName
      , Users.Email AS AdminEmail
      , Users_1.FirstName AS FacultyMemberFirstName
      , Users_1.LastName AS FacultyMemberLastName
      , Users_1.MiddleName AS FacultyMemberMiddleName
      , Users_1.Email AS FacultyMemberEmail
  FROM [dbo].[Courses]
  INNER JOIN Users ON [Courses].[AdminId] = [Users].[Id] 
  INNER JOIN Users AS Users_1 ON [Courses].[FacultyMemberId] = Users_1.Id
where [Courses].[Id] in (select Courses.Id from Courses
 INNER JOIN Surveys ON [Courses].[Id] = [Surveys].[CourseId] 
where Surveys.Approved = 1 and FacultyMemberId = @StudentId
)



END



SET ANSI_NULLS ON

GO
/****** Object:  StoredProcedure [dbo].[GetAllNotifications]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllNotifications]

@UserId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT DISTINCT top 1 [Courses].[Id]
      ,[Courses].[Name]
      ,[Courses].[CourseId]
      ,[Courses].[AdminId]
      ,[Courses].[FacultyMemberId]
      ,[Courses].[CreationDate]
      ,[Courses].[SectionNumber]
      ,[Courses].[NoOfLectures]
      , Users.FirstName AS AdminFirstName
      , Users.LastName AS AdminLastName
      , Users.MiddleName AS AdminMiddleName
      , Users.Email AS AdminEmail
      , Users_1.FirstName AS FacultyMemberFirstName
      , Users_1.LastName AS FacultyMemberLastName
      , Users_1.MiddleName AS FacultyMemberMiddleName
      , Users_1.Email AS FacultyMemberEmail
       ,Surveys.[SentToFacultyMember]
      ,Surveys.[Approved]
        ,Surveys.[LectureName]
      ,[Notifications].[Id] as NotificatioId,[Notifications].[Type] as NotificatioType 
  FROM [dbo].[Courses]
  INNER JOIN [Notifications] ON [Notifications].[CourseId] = [Courses].[Id]
  INNER JOIN Users ON [Courses].[AdminId] = [Users].[Id] 
  INNER JOIN Users AS Users_1 ON [Courses].[FacultyMemberId] = Users_1.Id
  left outer JOIN Surveys ON [Courses].[Id] = [Surveys].[CourseId] 
where [Notifications].[Readed] = 0 and UserId = @UserId and [Courses].[Id] in (
select [Notifications].[CourseId] from [Notifications] where [Notifications].[Readed] = 0 and UserId = @UserId)
  
  
END

GO
/****** Object:  StoredProcedure [dbo].[GetAllStudentBelongToCourse]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllStudentBelongToCourse]

@courseId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     Users.Id, Users.FirstName, Users.MiddleName, Users.LastName, 
	Users.Email, Users.UniversityNumber, Users.Password, Users.UserType, 
	Users.CreationDate
FROM         Users INNER JOIN
                      Courses_Students ON Users.Id = Courses_Students.StudentId
                      where Courses_Students.[CourseId] = @courseId 
	
END

GO
/****** Object:  StoredProcedure [dbo].[GetAllStudentCourses]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllStudentCourses]

@CourseId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select * from Courses_Students where CourseId = @CourseId

END

GO
/****** Object:  StoredProcedure [dbo].[GetAllStudentsCourses]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllStudentsCourses]

@StudentId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Courses].[Id]
,[Courses].[CourseId]
      ,[Courses].[Name]
      ,[Courses].[AdminId]
      ,[Courses].[FacultyMemberId]
      ,[Courses].[CreationDate]
      ,[Courses].[SectionNumber]
      ,[Courses].[NoOfLectures]
      , Users.FirstName AS AdminFirstName
      , Users.LastName AS AdminLastName
      , Users.MiddleName AS AdminMiddleName
      , Users.Email AS AdminEmail
      , Users_1.FirstName AS FacultyMemberFirstName
      , Users_1.LastName AS FacultyMemberLastName
      , Users_1.MiddleName AS FacultyMemberMiddleName
      , Users_1.Email AS FacultyMemberEmail
  FROM [dbo].[Courses]
  INNER JOIN Users ON [Courses].[AdminId] = [Users].[Id] 
  INNER JOIN Users AS Users_1 ON [Courses].[FacultyMemberId] = Users_1.Id
where [Courses].[Id] in (
select [Surveys].[CourseId] from CoordinatorMessages
INNER JOIN Surveys ON [CoordinatorMessages].[SurveyId] = [Surveys].[Id] 
INNER JOIN SurveyUsers ON [SurveyUsers].[SurveyId] = [Surveys].[Id] 
where SurveyUsers.StudentId = @StudentId and SurveyUsers.StudentType != 1)

END




SET ANSI_NULLS ON

GO
/****** Object:  StoredProcedure [dbo].[GetAllStudentsSurveysCourses]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllStudentsSurveysCourses]

@StudentId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SET NOCOUNT ON;

SELECT [Courses].[Id]
		,[Courses].[CourseId]
      ,[Courses].[Name]
      ,[Courses].[AdminId]
      ,[Courses].[FacultyMemberId]
      ,[Courses].[CreationDate]
      ,[Courses].[SectionNumber]
      ,[Courses].[NoOfLectures]
      , Users.FirstName AS AdminFirstName
      , Users.LastName AS AdminLastName
      , Users.MiddleName AS AdminMiddleName
      , Users.Email AS AdminEmail
      , Users_1.FirstName AS FacultyMemberFirstName
      , Users_1.LastName AS FacultyMemberLastName
      , Users_1.MiddleName AS FacultyMemberMiddleName
      , Users_1.Email AS FacultyMemberEmail
  FROM [dbo].[Courses]
  INNER JOIN Users ON [Courses].[AdminId] = [Users].[Id] 
  INNER JOIN Users AS Users_1 ON [Courses].[FacultyMemberId] = Users_1.Id
  
where [Courses].[Id] in (select distinct Courses_Students.CourseId from Courses_Students 
INNER JOIN [Courses] ON [Courses_Students].[CourseId] = [Courses].[Id] 
INNER JOIN [Surveys] ON [Courses].[Id] = [Surveys].[CourseId]
where Courses_Students.StudentId = @StudentId and Surveys.[Approved] = 1
and [Surveys].[DeadlineDate] > GetDate())

END

SET ANSI_NULLS ON
GO
/****** Object:  StoredProcedure [dbo].[GetAllStudentSurveys]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[GetAllStudentSurveys] 

@CourseId int
,@StudentId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


SELECT [Surveys].[Id]
      ,[Surveys].[CourseId]
      ,[Surveys].[DeadlineDate]
      ,[Surveys].[LectureName]
      ,[Surveys].[LectureNumber]
      ,[Surveys].[SentToFacultyMember]
      ,[Surveys].[Approved]
  FROM [dbo].[Surveys]
inner join SurveyUsers on SurveyUsers.[SurveyId] = [Surveys].[Id]
  where [Surveys].[CourseId] = @CourseId 
  and SurveyUsers.StudentId = @StudentId
  and SurveyUsers.StudentType = 2
  
END

GO
/****** Object:  StoredProcedure [dbo].[GetAllStudentUnderCourse]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllStudentUnderCourse]

@CourseId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select * from [Courses_Students] where CourseId = @CourseId

END

GO
/****** Object:  StoredProcedure [dbo].[GetAllSurveyQuestions]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllSurveyQuestions]


@SurveyId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT     Questions.Id, Questions.Title, Questions.Choice1, Questions.Choice2, Questions.Choice3, Questions.Choice4, Questions.RightChoice, Questions.SurveyId, 
                      Questions.StudentId
                      ,Users.FirstName as StudentFirstName
                      ,Users.MiddleName as StudentMiddleName
                      ,Users.LastName as StudentLastName
                      ,Users.Email as StudentEmail
                        ,Users.UniversityNumber as StudentUniversityNumber
FROM         Questions 

INNER JOIN Users ON Questions.[StudentId] = Users.Id
  where [Questions].[SurveyId] = @SurveyId
  
END

GO
/****** Object:  StoredProcedure [dbo].[GetAllSurveys]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllSurveys] 

@CourseId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT [Id]
      ,[CourseId]
      ,[DeadlineDate]
      ,[LectureName]
      ,[LectureNumber]
      ,[SentToFacultyMember]
      ,[Approved]
  FROM [dbo].[Surveys]
  where [CourseId] = @CourseId
  
END

GO
/****** Object:  StoredProcedure [dbo].[GetAllSurveysApproved]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[GetAllSurveysApproved] 

@CourseId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT [Id]
      ,[CourseId]
      ,[DeadlineDate]
      ,[LectureName]
      ,[LectureNumber]
      ,[SentToFacultyMember]
      ,[Approved]
  FROM [dbo].[Surveys]
  where [CourseId] = @CourseId
  and [Approved] = 1
  
END

GO
/****** Object:  StoredProcedure [dbo].[GetAllSurveysToAnswer]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllSurveysToAnswer] 

@CourseId int
,@StudentId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


SELECT [Surveys].[Id]
      ,[Surveys].[CourseId]
      ,[Surveys].[DeadlineDate]
      ,[Surveys].[LectureName]
      ,[Surveys].[LectureNumber]
      ,[Surveys].[SentToFacultyMember]
      ,[Surveys].[Approved]
  FROM [dbo].[Surveys]
inner join SurveyUsers on SurveyUsers.[SurveyId] = [Surveys].[Id]
  where [Surveys].[CourseId] = @CourseId 
  and SurveyUsers.StudentId = @StudentId
  and Surveys.[Approved] = 1
  
  UNION
  
    SELECT [Surveys].[Id]
      ,[Surveys].[CourseId]
      ,[Surveys].[DeadlineDate]
      ,[Surveys].[LectureName]
      ,[Surveys].[LectureNumber]
      ,[Surveys].[SentToFacultyMember]
      ,[Surveys].[Approved]
  FROM [dbo].[Surveys]
 inner join Courses_Students on Courses_Students.CourseId = [Surveys].[CourseId]
  where [Surveys].[CourseId] = @CourseId 
  and Courses_Students.StudentId = @StudentId
  and Surveys.[Approved] = 1
  
  
END

GO
/****** Object:  StoredProcedure [dbo].[GetAllUsers]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllUsers]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from Users where UserType <> '1' order by FirstName,MiddleName
END

GO
/****** Object:  StoredProcedure [dbo].[GetAnswer]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[GetAnswer]


@QuestionId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select * from SurveyAnswers 
where QuestionId = @QuestionId
  
END

GO
/****** Object:  StoredProcedure [dbo].[GetFacultyMemberCourses]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetFacultyMemberCourses]

@FacultyMemberId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Courses].[Id]
	   ,[Courses].[CourseId]
      ,[Courses].[Name]
      ,[Courses].[AdminId]
      ,[Courses].[FacultyMemberId]
      ,[Courses].[CreationDate]
      ,[Courses].[SectionNumber]
      ,[Courses].[NoOfLectures]
      , Users.FirstName AS AdminFirstName
      , Users.LastName AS AdminLastName
      , Users.MiddleName AS AdminMiddleName
      , Users.Email AS AdminEmail
      , Users_1.FirstName AS FacultyMemberFirstName
      , Users_1.LastName AS FacultyMemberLastName
      , Users_1.MiddleName AS FacultyMemberMiddleName
      , Users_1.Email AS FacultyMemberEmail
     
  FROM [dbo].[Courses]
  INNER JOIN Users ON [Courses].[AdminId] = [Users].[Id] 
  INNER JOIN Users AS Users_1 ON [Courses].[FacultyMemberId] = Users_1.Id
    
where [Courses].[FacultyMemberId] = @FacultyMemberId

END

SET ANSI_NULLS ON

GO
/****** Object:  StoredProcedure [dbo].[GetMessage]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetMessage]
@SurveyId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT [Id]
      ,[Message]
      ,[SurveyId]
  FROM [dbo].[CoordinatorMessages]
  where [SurveyId] = @SurveyId
  
END

GO
/****** Object:  StoredProcedure [dbo].[GetSurveyUsers]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSurveyUsers]

@SurveyId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select Users.* from SurveyUsers
inner Join Users on Users.Id = SurveyUsers.StudentId
 where SurveyUsers.SurveyId = @SurveyId and SurveyUsers.StudentType = '2'


END

GO
/****** Object:  StoredProcedure [dbo].[MessageSent]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[MessageSent]

@SurveyId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

/****** Script for SelectTopNRows command from SSMS  ******/
select Courses.* from Courses
inner join Surveys on Surveys.[CourseId] = Courses.Id
inner join CoordinatorMessages on CoordinatorMessages.[SurveyId] = Surveys.[Id] 
where CoordinatorMessages.SurveyId = @SurveyId

END

GO
/****** Object:  StoredProcedure [dbo].[Notification_Update]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[Notification_Update] 

@Id int
           
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

UPDATE [dbo].[Notifications]
   SET [Readed] = 1
 WHERE [Id] = @Id

END

GO
/****** Object:  StoredProcedure [dbo].[Question_Delete]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[Question_Delete] 

@Id int
AS
BEGIN

SET NOCOUNT ON;

Delete from Questions where Id = @Id

END

GO
/****** Object:  StoredProcedure [dbo].[QuestionAdd]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[QuestionAdd] 

@Id int output
,@Title  nvarchar(100)
,@Choice1  nvarchar(100)
,@Choice2  nvarchar(100)
,@Choice3  nvarchar(100)
           ,@Choice4  nvarchar(100)
           ,@RightChoice int
           ,@SurveyId int
           ,@StudentId int
           
AS
BEGIN

SET NOCOUNT ON;

INSERT INTO [dbo].[Questions]
           ([Title]
           ,[Choice1]
           ,[Choice2]
           ,[Choice3]
           ,[Choice4]
           ,[RightChoice]
           ,[SurveyId]
           ,[StudentId])
     VALUES
           (@Title
           ,@Choice1
           ,@Choice2
           ,@Choice3
           ,@Choice4
           ,@RightChoice
           ,@SurveyId
           ,@StudentId)

set @Id = SCOPE_IDENTITY()
END


GO
/****** Object:  StoredProcedure [dbo].[QuestionAdded]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[QuestionAdded]

@SurveyId int
,@StudentId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

/****** Script for SelectTopNRows command from SSMS  ******/
select Courses.* from Courses
inner join Surveys on Surveys.[CourseId] = Courses.Id
inner join Questions on Questions.[SurveyId] = Surveys.[Id] 
where Questions.SurveyId = @SurveyId and Questions.StudentId=@StudentId

END

GO
/****** Object:  StoredProcedure [dbo].[Survey_FacultyMemberApprove]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[Survey_FacultyMemberApprove] 

@Id int
           
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

UPDATE [MCQ4U].[dbo].[Surveys]
   SET [Approved] = '1'
   
 WHERE [Id] = @Id

END

GO
/****** Object:  StoredProcedure [dbo].[Survey_UpdateSentToFacultyMember]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[Survey_UpdateSentToFacultyMember] 

@Id int
           
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

UPDATE [MCQ4U].[dbo].[Surveys]
   SET [SentToFacultyMember] = '1'
   
 WHERE [Id] = @Id

END

GO
/****** Object:  StoredProcedure [dbo].[SurveyAdd]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SurveyAdd] 

@Id int output
,@CourseId int
,@DeadlineDate nvarchar(100)
,@LectureName nvarchar(100)
,@LectureNumber int
           
AS
BEGIN

SET NOCOUNT ON;

INSERT INTO [MCQ4U].[dbo].[Surveys]
           ([CourseId]
           ,[DeadlineDate]
           ,[LectureName]
           ,[LectureNumber]
           ,[SentToFacultyMember])
     VALUES
           (@CourseId
           ,@DeadlineDate
           ,@LectureName
           ,@LectureNumber
           ,0)

set @Id = SCOPE_IDENTITY()
END


GO
/****** Object:  StoredProcedure [dbo].[SurveyAdded]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[SurveyAdded]

@CourseId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

/****** Script for SelectTopNRows command from SSMS  ******/
select Courses.* from Courses
inner join Surveys on Surveys.[CourseId] = Courses.Id
where Surveys.CourseId = @CourseId

END

GO
/****** Object:  StoredProcedure [dbo].[SurveyAnswered]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SurveyAnswered]

@SurveyId int,
@StudentId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select * from SurveyAnswers where SurveyId = @SurveyId and StudentId = @StudentId


END

GO
/****** Object:  StoredProcedure [dbo].[SurveyGetCoordinator]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SurveyGetCoordinator]

@SurveyId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select * from  SurveyUsers where SurveyId = @SurveyId and StudentType = '1'

END

GO
/****** Object:  StoredProcedure [dbo].[SurveysGetFacultyMemberId]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SurveysGetFacultyMemberId]
@SurveyId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


		select Courses.* from  Surveys
		inner join Courses on Courses.Id = Surveys.CourseId 
		where Surveys.Id = @SurveyId

END

GO
/****** Object:  StoredProcedure [dbo].[SurveyUserAdd]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[SurveyUserAdd] 

@Id int output
,@SurveyId int
,@StudentId int
,@StudentType int
           
AS
BEGIN

SET NOCOUNT ON;

INSERT INTO [dbo].[SurveyUsers]
           ([SurveyId]
           ,[StudentId]
           ,[StudentType])
     VALUES
           (@SurveyId
           ,@StudentId
           ,@StudentType)

set @Id = SCOPE_IDENTITY()
END


GO
/****** Object:  StoredProcedure [dbo].[Users_Delete]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Users_Delete] 

@Id int
           
AS
BEGIN

SET NOCOUNT ON;

Delete FROM [dbo].[Users] WHERE Id = @Id

END

GO
/****** Object:  StoredProcedure [dbo].[Users_Get]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[Users_Get] 

@Id int
           
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT * FROM [dbo].[Users] WHERE [Id] = @Id

END

GO
/****** Object:  StoredProcedure [dbo].[Users_Login]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Users_Login] 

@UniversityNumber nvarchar(100),
@Password nvarchar(50)
           
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT * FROM [dbo].[Users] WHERE [UniversityNumber] = @UniversityNumber and [Password]= @Password

END

GO
/****** Object:  StoredProcedure [dbo].[Users_Register]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Users_Register] 

@Id int output,
@FirstName nvarchar(100),
@MiddleName nvarchar(100),
@LastName nvarchar(100),
@UniversityNumber nvarchar(50),
@Password nvarchar(50),
@UserType int
           
AS
BEGIN

SET NOCOUNT ON;

IF EXISTS(SELECT Id
          FROM [dbo].[Users] 
          where [UniversityNumber] = @UniversityNumber)
BEGIN
set @Id = -1
END
ELSE
BEGIN
INSERT INTO [dbo].[Users]
           ([FirstName]
           ,[MiddleName]
			,[LastName]
           ,[UniversityNumber]
           ,[Password]
           ,[UserType]
           ,[CreationDate])
     VALUES
           (@FirstName,
           @MiddleName,
           @LastName,
            @UniversityNumber,
            @Password,
            @UserType,
            GETDATE())

set @Id = SCOPE_IDENTITY()
END

END

GO
/****** Object:  StoredProcedure [dbo].[Users_Update]    Script Date: 09/12/2017 7:17:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Users_Update] 

@Id int,
@FirstName nvarchar(100),
@MiddleName nvarchar(100),
@LastName nvarchar(100),
@UniversityNumber nvarchar(50),
@Password nvarchar(50)
           
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

UPDATE [dbo].[Users]
   SET 
   [FirstName]=@FirstName
           ,[MiddleName]=@MiddleName
			,[LastName]=@LastName
      ,[UniversityNumber] = @UniversityNumber
      ,[Password] = @Password
 WHERE [Id] = @Id

END

GO
USE [master]
GO
ALTER DATABASE [MCQ4U] SET  READ_WRITE 
GO
