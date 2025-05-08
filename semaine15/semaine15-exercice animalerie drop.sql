USE [animalerie]
GO

IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'trg_SoftDeleteEmploye' AND parent_id = OBJECT_ID('dbo.employes'))
BEGIN
    DROP TRIGGER [dbo].[trg_SoftDeleteEmploye];
END
GO

IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'trg_LimiterAnimauxParEnclos' AND parent_id = OBJECT_ID('dbo.enclos_pensions_animaux'))
BEGIN
    DROP TRIGGER [dbo].[trg_LimiterAnimauxParEnclos];
END
GO

/****** Object:  Table [dbo].[enclos_pensions_animaux]    Script Date: 2025-04-22 14:43:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[enclos_pensions_animaux]') AND type in (N'U'))
DROP TABLE [dbo].[enclos_pensions_animaux]
GO


/****** Object:  Table [dbo].[pensions]    Script Date: 2025-04-22 14:43:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pensions]') AND type in (N'U'))
DROP TABLE [dbo].[pensions]
GO

/****** Object:  Table [dbo].[enclos]    Script Date: 2025-04-22 14:43:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[enclos]') AND type in (N'U'))
DROP TABLE [dbo].[enclos]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[soins_animaux]') AND type in (N'U'))
DROP TABLE [dbo].[soins_animaux]
GO

/****** Object:  Table [dbo].[soins]    Script Date: 2025-05-07 15:19:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[soins]') AND type in (N'U'))
DROP TABLE [dbo].[soins]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[employes]') AND type in (N'U'))
DROP TABLE [dbo].[employes]
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[animaux]') AND type in (N'U'))
DROP TABLE [dbo].[animaux]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[clients]') AND type in (N'U'))
DROP TABLE [dbo].[clients]
GO