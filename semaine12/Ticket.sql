IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'tickets2')
BEGIN
    CREATE DATABASE tickets2;
    PRINT 'La base de données a été créée.';
END
ELSE
BEGIN
    PRINT 'La base de données existe déjà.';
END
GO

use tickets2;
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'utilisateurs')
BEGIN
    PRINT 'La table utilisateurs existe déjà.';
END
ELSE
BEGIN
    CREATE TABLE utilisateurs (
        id INT IDENTITY PRIMARY KEY,
        nom VARCHAR(100) NOT NULL,
        prenom VARCHAR(100) NOT NULL
    );
END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'projets')
BEGIN
    PRINT 'La table projets existe déjà.';
END
ELSE
BEGIN
    CREATE TABLE projets (
        id INT IDENTITY PRIMARY KEY,
        nom VARCHAR(50) NOT NULL,
        date_creation DATETIME2 NOT NULL, 
        cloture BIT default 0,
        id_responsable int NOT NULL,
        CONSTRAINT FK_projets_utilisateurs FOREIGN KEY (id_responsable) REFERENCES utilisateurs (id)
    );
END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'statuts')
BEGIN
    PRINT 'La table statuts existe déjà.';
END
ELSE
BEGIN
    CREATE TABLE statuts (
        id int IDENTITY PRIMARY key,
        libelle VARCHAR(100) NOT NULL UNIQUE
    );
END

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'tickets')
BEGIN
    PRINT 'La table Tickets existe déjà.';
END
ELSE
BEGIN
    CREATE TABLE tickets (
        id INT IDENTITY PRIMARY KEY,
        titre NVARCHAR(100),
        date_creation Datetime2 DEFAULT GETDATE(),
        description NVARCHAR(3000),
        id_auteur int NOT NULL,
        id_projet int NOT NULL,
        id_statut_actuel int NOT NULL DEFAULT 1,
        CONSTRAINT FK_tickets_utilisateurs FOREIGN KEY (id_auteur) REFERENCES utilisateurs (id),
        CONSTRAINT FK_tickets_projets FOREIGN KEY (id_projet) REFERENCES projets (id) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT FK_tickets_statuts FOREIGN KEY (id_statut_actuel) REFERENCES statuts (id),
    );
END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'commentaires')
BEGIN
    PRINT 'La table commentaires existe déjà.';
END
ELSE
BEGIN
    CREATE TABLE commentaires (
        id INT IDENTITY PRIMARY KEY,
        descriptions VARCHAR(1000) NOT NULL,
        id_utilisateur int NOT NULL,
        id_ticket int NOT NULL,
        CONSTRAINT FK_commentaire_utilisateurs FOREIGN KEY (id_utilisateur) REFERENCES utilisateurs(id),
        CONSTRAINT FK_commentaire_tickets FOREIGN KEY (id_ticket) REFERENCES tickets(id) on DELETE CASCADE on UPDATE CASCADE
    );
END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'niveaux_bugs')
BEGIN
    PRINT 'La table niveaux_bugs existe déjà.';
END
ELSE
BEGIN
    CREATE TABLE niveaux_bugs (
        id INT IDENTITY PRIMARY KEY,
        ordre INT NOT NULL,
        libelle VARCHAR(20) NOT NULL
    );
END



IF EXISTS (SELECT * FROM sys.tables WHERE name = 'versions')
BEGIN
    PRINT 'La table versions existe déjà.';
END
ELSE
BEGIN
    CREATE TABLE versions (
        id INT IDENTITY PRIMARY KEY,
        numero VARCHAR(50),
        id_projet int NOT NULL,
		CONSTRAINT unique_numero_id_projet UNIQUE (numero, id_projet),
        CONSTRAINT FK_versions_projets FOREIGN KEY (id_projet) REFERENCES projets(id) on DELETE CASCADE on UPDATE CASCADE
    );
END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'evolutions')
BEGIN
    PRINT 'La table evolutions existe déjà.';
END
ELSE
BEGIN
    CREATE TABLE evolutions (
        id_evolution INT IDENTITY PRIMARY KEY,
        priorite INT,
        id_ticket int NOT NULL,
        CONSTRAINT FK_evolutions_tickets FOREIGN KEY (id_ticket) REFERENCES tickets(id)
    );
END

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'bugs')
BEGIN
    PRINT 'La table bugs existe déjà.';
END
ELSE
BEGIN
    CREATE TABLE bugs (
        id INT IDENTITY PRIMARY KEY,
        id_ticket int NOT NULL,
		id_niveau_bug int NOT NULL default 1 
        CONSTRAINT FK_bugs_tickets FOREIGN KEY (id_ticket) REFERENCES tickets(id),
		CONSTRAINT FK_bugs_niveau_bugs FOREIGN KEY (id_niveau_bug) REFERENCES niveaux_bugs(id)
    );
END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'bugs_versions')
BEGIN
    PRINT 'La table bugs_version_associee existe déjà.';
END
ELSE
BEGIN
    CREATE TABLE bugs_versions (
        id INT IDENTITY PRIMARY KEY,
        id_bug int NOT NULL,
        id_version_associee int NOT NULL,
        CONSTRAINT FK_bugs_version_associee_bugs FOREIGN KEY (id_bug) REFERENCES bugs(id),
        CONSTRAINT FK_bugs_version_associee_versions FOREIGN KEY (id_version_associee) REFERENCES versions(id)
    );
END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'tickets_associes')
BEGIN
    PRINT 'La table tickets_associes existe déjà.';
END
ELSE
BEGIN
    CREATE TABLE tickets_associes (
        id int IDENTITY PRIMARY key,
        id_ticket_associe int NOT NULL,
        id_ticket int NOT NULL
        
        CONSTRAINT FK_tickets_associes_tickets FOREIGN KEY (id_ticket_associe) REFERENCES tickets(id),
        CONSTRAINT FK_tickets_tickets_associes FOREIGN KEY (id_ticket) REFERENCES tickets(id)
    );
END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'historique')
BEGIN
    PRINT 'La table historique existe déjà.';
END
ELSE
BEGIN
    CREATE TABLE historique (
        id int IDENTITY PRIMARY key,
        date DATETIME2 default GETDATE(),
        id_utilisateur int NOT NULL,
        id_commentaire int,
        id_ticket int NOT NULL,
        id_statut int NOT NULL,
        CONSTRAINT FK_historique_utilisateurs FOREIGN KEY (id_utilisateur) REFERENCES utilisateurs (id),
        CONSTRAINT FK_historique_commentaires FOREIGN KEY (id_commentaire) REFERENCES commentaires (id),
        CONSTRAINT FK_historique_tickets FOREIGN KEY (id_ticket) REFERENCES tickets (id)
    );
END


IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'trg_AfterInsertTicket' AND parent_id = OBJECT_ID('tickets'))
BEGIN
    DROP TRIGGER trg_AfterInsertTicket;
    PRINT 'Le déclencheur existant a été supprimé.';
END;
GO  


CREATE TRIGGER trg_AfterInsertTicket 
ON tickets  
AFTER INSERT    
  AS 
    BEGIN
        INSERT INTO historique (date, id_utilisateur, id_ticket, id_statut)
        SELECT 
            GETDATE(),  -- Date actuelle
            id_auteur,  -- Utilisateur qui a effectué la mise à jour
            tickets.id,  -- Ticket associé à la mise à jour
            id_statut_actuel
        FROM tickets
        END; 



IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'trg_AfterUpdateTicketStatus' AND parent_id = OBJECT_ID('tickets'))
BEGIN
    DROP TRIGGER trg_AfterUpdateTicketStatus;
    PRINT 'Le déclencheur existant a été supprimé.';
END;
GO 


CREATE TRIGGER trg_AfterUpdateTicketStatus  
ON tickets  
AFTER UPDATE    
  AS 
  IF UPDATE(id_statut_actuel)
        BEGIN
            INSERT INTO historique (date, id_utilisateur, id_ticket, id_commentaire, id_statut)
            SELECT 
                GETDATE(),  -- Date actuelle
                i.id_auteur,  -- Utilisateur qui a effectué la mise à jour
                i.id,  -- Ticket associé à la mise à jour
                commentaires.id,
                i.id_statut_actuel
            FROM inserted i 
            INNER JOIN deleted d ON i.id = d.id  
            INNER JOIN commentaires ON i.id = commentaires.id_ticket
            WHERE i.id_statut_actuel <> d.id_statut_actuel ;  -- Condition pour insérer uniquement si le statut a changé
        END; 
  







