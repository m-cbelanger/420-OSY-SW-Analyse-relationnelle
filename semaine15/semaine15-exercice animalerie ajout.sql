USE [animalerie]
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'soins')
BEGIN
    PRINT 'La table soins existe déjà.';
END
ELSE
BEGIN
    CREATE TABLE soins (
        id INT IDENTITY PRIMARY KEY,
        id_employe TINYINT NOT NULL default 1,
		date_traitement DATETIME2 NOT NULL DEFAULT GETDATE(),
		type_soins VARCHAR(100) NOT NULL,
		prix DECIMAL(10,2),
		CONSTRAINT FK_soins_employes FOREIGN KEY (id_employe) REFERENCES employes(id) ON DELETE SET DEFAULT ON UPDATE CASCADE
    );
END

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'soins_animaux')
BEGIN
    PRINT 'La table soins_animaux existe déjà.';
END
ELSE
BEGIN
    CREATE TABLE soins_animaux (
        id INT IDENTITY PRIMARY KEY,
        id_soins INT NOT NULL,
		id_animaux VARCHAR(20) NOT NULL,
		CONSTRAINT FK_soins_animaux_animaux FOREIGN KEY (id_animaux) REFERENCES animaux(id) ON UPDATE CASCADE,
		CONSTRAINT FK_soins_animaux_soins FOREIGN KEY (id_soins) REFERENCES soins(id) ON UPDATE CASCADE
    );
END

ALTER TABLE employes
ADD est_actif BIT NOT NULL DEFAULT 1


IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'trg_SoftDeleteEmploye' AND parent_id = OBJECT_ID('dbo.employes'))
BEGIN
    DROP TRIGGER [dbo].[trg_SoftDeleteEmploye];
END
GO

CREATE TRIGGER trg_SoftDeleteEmploye
ON dbo.employes
INSTEAD OF DELETE
AS
BEGIN
    -- On remplace la suppression par une mise à jour du champ est_actif
    UPDATE e
    SET est_actif = 0
    FROM dbo.employes e
    INNER JOIN deleted d ON e.id = d.id;
END;

