use tickets2;
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bugs_version_associee]') AND type in (N'U'))
DROP TABLE [dbo].[bugs_version_associee]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[historique]') AND type in (N'U'))
DROP TABLE [dbo].[historique]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tickets_associes]') AND type in (N'U'))
DROP TABLE [dbo].[tickets_associes]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bugs_versions]') AND type in (N'U'))
DROP TABLE [dbo].[bugs_versions]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[versions]') AND type in (N'U'))
DROP TABLE [dbo].[versions]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bugs]') AND type in (N'U'))
DROP TABLE [dbo].[bugs]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[evolutions]') AND type in (N'U'))
DROP TABLE [dbo].[evolutions]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[niveaux_bugs]') AND type in (N'U'))
DROP TABLE [dbo].[niveaux_bugs]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[commentaires]') AND type in (N'U'))
DROP TABLE [dbo].[commentaires]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tickets]') AND type in (N'U'))
DROP TABLE [dbo].[tickets]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[statuts]') AND type in (N'U'))
DROP TABLE [dbo].[statuts]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[projets]') AND type in (N'U'))
DROP TABLE [dbo].[projets]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[utilisateurs]') AND type in (N'U'))
DROP TABLE [dbo].[utilisateurs]
GO

IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'trg_AfterUpdateTicketStatus' AND parent_id = OBJECT_ID('tickets'))
BEGIN
    DROP TRIGGER trg_AfterUpdateTicketStatus;
    PRINT 'Le déclencheur existant a été supprimé.';
END;
GO  

IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'trg_AfterInsertTicket' AND parent_id = OBJECT_ID('tickets'))
BEGIN
    DROP TRIGGER trg_AfterInsertTicket;
    PRINT 'Le déclencheur existant a été supprimé.';
END;
GO  
