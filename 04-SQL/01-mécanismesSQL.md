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
## Seed (insérer les données de départ dans la BD) 

Sert à :

- tester la BD (vérifier que les relations et contraintes fonctionnent)
- peupler des tables avec des valeurs de référence (éviter d'avoir des tables vides, pratique pour tester)


