# SQL Server
Certains mécanismes sont intéressants à implémenter en BD pour répondre aux besoins du MRD. Dans le cadre de ce cours, nous travaillerons avec Miscrosoft SQL Server. L'éditeur pour écrire nos requêtes sera SSMS (SQL Server Management Studio)

MariaDB utilisé en BD1 est un moteur de BD open source très utilisé en web et dans l'environnement Linux. SQL server se rapproche plus du dialecte T-SQL (Transact-SQL) très utilisé dans l'environnement Windows et en entreprise.

La syntaxe générale reste la même (SELECT, FROM, WHERE, UPDATE, CREATE, JOIN, etc.), mais quelques différences sont à considérer, notamment dans la logique procédurale (ce qu'il y a autour)

# Détail de syntaxe


## La clause if not exists

Avec SQL server, la façon d'indiquer "if not exists" pour la création ou la suppression des tables est différente (logique procédurale). il faut donc vérifier si la table fait partie de sys.tables explicitement plutôt que de le mettre dans le script de CREATE TABLE. Le IF est suivi d'un BEGIN et se termine avec un END. Remarquez aussi que l'auto-incrémentation est devenu IDENTITY(1,1), ce qui signifie que l'auto incrémentation commence à 1 et fait des pas de 1.

```sql
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'exemple')
BEGIN
    CREATE DATABASE exemple;
END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'inscriptions')
BEGIN
    CREATE TABLE inscriptions (
        id INT IDENTITY(1,1) PRIMARY KEY,
        id_etudiant INT,
        id_cours INT
    );
END
```

Si vous changez la création de la table, la meilleure option est un drop suivi d'un CREATE. 
```sql
IF EXISTS (SELECT * FROM sys.tables WHERE name = N'inscriptions')
BEGIN
	DROP TABLE inscriptions;
END
CREATE TABLE inscriptions (
        id INT IDENTITY(1,1) PRIMARY KEY,
        id_etudiant INT,
        id_cours INT
);
```


## Le mot clé GO

GO n’est pas une commande SQL à proprement parler, mais un séparateur de batch utilisé par SQL Server Management Studio (SSMS) et certains autres outils.

Certaines commandes doivent être le premier élément d’un batch pour être acceptées, par exemple :
- CREATE TRIGGER
- CREATE VIEW
- CREATE PROCEDURE


## La contrainte Unique
La contrainte UNIQUE sert à empêcher les doublons dans une colonne ou un groupe de colonnes d’une table.

Elle garantit que chaque valeur est différente (comme une clé primaire, mais sans être forcément la clé de la table).

```sql
CREATE TABLE employes (
    id INT PRIMARY KEY,
    matricule VARCHAR(10) UNIQUE,
    nom VARCHAR(50)
);
```

Possible sur plusieurs colonnes:
```sql
CREATE TABLE inscriptions (
    id INT PRIMARY KEY,
    id_etudiant INT,
    id_cours INT,
    UNIQUE (id_etudiant, id_cours)
);
```
Bon à savoir:
- Une colonne UNIQUE a le droit de contenir plusieurs NULL (car NULL ≠ NULL, donc pas vu comme doublon).
- Il est possible d'avoir plusieurs contraintes UNIQUE dans une même table (contrairement à PRIMARY KEY).
- UNIQUE crée automatiquement un index pour optimiser la recherche.

## La clause CHECK

Une contrainte CHECK sert à valider les données avant qu'elles ne soient insérées ou modifiées dans une table. Elle empêche qu’une ligne soit insérée ou modifiée si la condition définie n’est pas respectée.

Ça ne s'applique que sur la ligne courante. Ça n'a pas d'impact sur les autres lignes ou les autres tables (PAS possible d'y mettre le calcul impliquant les autres valeurs de la colonne, comme par exemple CHECK prix < MAX(prix)). 

- On peut y mettre les opérateurs logiques comme AND, OR, NOT, =, <>, >, <, >=, <=, etc.
- Les valeurs NULL ne sont jamais testées dans une contrainte CHECK. Donc une ligne avec prix à NULL passe même si prix >= 0 est spécifié.
- Pas de jointure
- Pas de sous-requête

```sql
CREATE TABLE produits (
    id INT PRIMARY KEY,
    nom VARCHAR(50),
    prix DECIMAL(10,2) CHECK (prix >= 0)
);
```


## L'objet trigger

Un trigger est une commande qui est déclenchée en réaction à une autre action en BD

| Raisons d’utiliser un TRIGGER     | Explication |
|----------------------------------|-------------|
| **Centralisation de la logique** | La logique métier est exécutée dans la BD, ce qui assure qu'elle est toujours appliquée peu importe l'application ou le langage qui accède à la BD. |
| **Automatisation**               | Permet de déclencher automatiquement une action (ex. : mise à jour d’un historique, validation, synchronisation) sans coder cette action à chaque fois. |
| **Sécurité**                     | Évite que la logique soit contournée par une erreur ou un oubli dans l'application. |
| **Maintenance**                  | Moins de duplication de code, plus facile à modifier dans un seul endroit. |


[Trigger en SQL server](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-trigger-transact-sql?view=sql-server-ver16)


Par exemple, si on veut créer un trigger pour créer une facture dès l'insertion d'une commande au resto:

```sql
-- ne pas oublier le drop préalable pour rouler le script plusieurs fois
CREATE TABLE commandes (
    id INT IDENTITY(1,1) PRIMARY KEY,
    numero_table INT NOT NULL,
    numero_client INT NOT NULL,
    date_commande DATETIME NOT NULL DEFAULT GETDATE()
    -- id_serveur retiré pour plus de simplicité pour l'explication
);


CREATE TABLE factures (
    id INT IDENTITY(1,1) PRIMARY KEY,
    -- Enlever pour simplifier de l'explication
    -- numero_addition INT NOT NULL, 
    id_commande INT NOT NULL,
    date_facture DATETIME NOT NULL DEFAULT GETDATE(),
    total DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (id_commande) REFERENCES Commande(id_commande),
   -- TPS enlevé pour garder une simplicité pour l'explication 
);
```

Trigger qui insert une ligne facture en réaction à la ligne commande qui est créée

```sql
CREATE TRIGGER trg_commande_insert
ON commandes
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO factures (id_commande, date_facture, total)
    SELECT id_commande, GETDATE(), 0
    FROM inserted;
END;
```

### Script complet pour que ça marche:
```sql
-- ne pas oublier le drop préalable pour rouler le script plusieurs fois
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'exemple')
BEGIN
    CREATE DATABASE exemple;
END
GO
USE exemple;
-- drop à l'envers des create pour les FK


IF EXISTS (SELECT * FROM sys.tables WHERE name = N'factures')
BEGIN
	DROP TABLE factures;
END
GO
IF EXISTS (SELECT * FROM sys.tables WHERE name = N'commandes')
BEGIN
	DROP TABLE commandes;
END
GO



-- créations
CREATE TABLE commandes (
    id INT IDENTITY(1,1) PRIMARY KEY,
    numero_table INT NOT NULL,
    numero_client INT NOT NULL,
    date_commande DATETIME NOT NULL DEFAULT GETDATE()
    -- id_serveur retiré pour plus de simplicité pour l'explication
);

CREATE TABLE factures (
    id INT IDENTITY(1,1) PRIMARY KEY,
    -- Enlever pour simplifier de l'explication
    -- numero_addition INT NOT NULL, 
    id_commande INT NOT NULL,
    date_facture DATETIME NOT NULL DEFAULT GETDATE(),
    total DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (id_commande) REFERENCES commandes(id),
   -- TPS enlevé pour garder une simplicité pour l'explication 
);
GO


USE exemple;
GO

IF OBJECT_ID('trg_commande_insert', 'TR') IS NOT NULL
BEGIN
    DROP TRIGGER trg_commande_insert;
END
GO

CREATE TRIGGER trg_commande_insert
ON commandes
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO factures (id_commande, date_facture, total)
    SELECT id, GETDATE(), 0
    FROM inserted;
END;
GO
```

Maintenant faire une insertion dans la table appropriée et observez si ça fonctionne dans l'autre