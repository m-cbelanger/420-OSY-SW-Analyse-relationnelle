
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'animalerie')
BEGIN
    CREATE DATABASE animalerie;
    PRINT 'La base de données a été créée.';
END
ELSE
BEGIN
    PRINT 'La base de données existe déjà.';
END
GO

use animalerie;

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'clients')
BEGIN
    PRINT 'La table clients existe déjà.';
END
ELSE
BEGIN
    CREATE TABLE clients (
        id INT IDENTITY PRIMARY KEY,
        nom VARCHAR(100) NOT NULL,
        num_tel VARCHAR(20) NOT NULL,
		adresse VARCHAR(300),
		courriel VARCHAR(254) UNIQUE
    );
END

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'employes')
BEGIN
    PRINT 'La table employes existe déjà.';
END
ELSE
BEGIN
    CREATE TABLE employes (
        id TINYINT IDENTITY PRIMARY KEY,
        nom VARCHAR(100) NOT NULL
    );
END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'enclos')
BEGIN
    PRINT 'La table enclos existe déjà.';
END
ELSE
BEGIN
    CREATE TABLE enclos (
        id INT IDENTITY PRIMARY KEY,
        numero_alpha VARCHAR(10) NOT NULL UNIQUE
    );
END

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'animaux')
BEGIN
    PRINT 'La table animaux existe déjà.';
END
ELSE
BEGIN
    CREATE TABLE animaux (
        id VARCHAR(20) PRIMARY KEY,
        id_client INT NOT NULL,
		nom VARCHAR(50) NOT NULL, 
		espece VARCHAR(50),
		race VARCHAR(50),
		couleur VARCHAR(50),
		qte_nourriture DECIMAL(10,2),
		nb_repas TINYINT,
		prend_medic BIT,
		CONSTRAINT FK_animaux_clients FOREIGN KEY (id_client) REFERENCES clients(id) ON DELETE CASCADE ON UPDATE CASCADE
    );
END

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'pensions')
BEGIN
    PRINT 'La table pensions existe déjà.';
END
ELSE
BEGIN
    CREATE TABLE pensions (
        id INT IDENTITY PRIMARY KEY,
        id_employe TINYINT NOT NULL default 1,
		date_arrivee DATETIME2 NOT NULL,
		date_depart DATETIME2,
		CONSTRAINT FK_pensions_employes FOREIGN KEY (id_employe) REFERENCES employes(id) ON DELETE SET DEFAULT ON UPDATE CASCADE
    );
END



IF EXISTS (SELECT * FROM sys.tables WHERE name = 'enclos_pensions_animaux')
BEGIN
    PRINT 'La table enclos_pensions_animaux existe déjà.';
END
ELSE
BEGIN
    CREATE TABLE enclos_pensions_animaux (
        id INT IDENTITY PRIMARY KEY,
        id_animal VARCHAR(20) NOT NULL,
		id_pension INT NOT NULL,
		id_enclos INT,
		CONSTRAINT FK_e_p_a_animaux FOREIGN KEY (id_animal) REFERENCES animaux(id) ON DELETE CASCADE ON UPDATE CASCADE,
		CONSTRAINT FK_e_p_a_pensions FOREIGN KEY (id_pension) REFERENCES pensions(id) ON DELETE CASCADE ON UPDATE CASCADE,
		CONSTRAINT FK_e_p_a_enclos FOREIGN KEY (id_enclos) REFERENCES enclos(id) ON DELETE SET NULL ON UPDATE CASCADE,
		CONSTRAINT UK_animal_pension UNIQUE (id_animal, id_pension),
    );
END

IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'trg_LimiterAnimauxParEnclos' AND parent_id = OBJECT_ID('dbo.enclos_pensions_animaux'))
BEGIN
    DROP TRIGGER [dbo].[trg_LimiterAnimauxParEnclos];
END
GO

CREATE TRIGGER trg_LimiterAnimauxParEnclos
ON enclos_pensions_animaux
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN enclos_pensions_animaux epa
            ON epa.id_enclos = i.id_enclos AND epa.id_pension = i.id_pension
        GROUP BY epa.id_enclos, epa.id_pension
        HAVING COUNT(*) > 4
    )
    BEGIN
        RAISERROR('Un enclos ne peut contenir plus de 4 animaux pour une même pension.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;


