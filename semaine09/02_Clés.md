## Les clés

- Vous connaissez probablement deux types de clés, soit la clé primaire et la clé étrangère (ou Foreign key)
    - L’une sert à identifier uniquement un enregistrement soit la clé primaire
    - L’autre sert à identifier un enregistrement « parent » soit la clé étrangère
- En ce qui concerne la clé primaire, il peut y avoir un ou plusieurs champs qui permettent d’identifier un enregistrement de façon unique.
    - Par exemple pour le système éducatif : votre numéro d’étudiant local, votre numéro au ministère ou un numéro incrémenté automatiquement.

Décortiquons le tout:

## Base de données

Dans les notes de cours, on fera de plus en plus souvent des scripts SQL. Dans SSMS, on se créera une base de données pour le cours. Appelons-la `analyse`.

```SQL
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'analyse')
BEGIN
    CREATE DATABASE analyse;
END
```


## Clé primaire

La clé primaire est sélectionnée parmi les champs déjà présents (les clés **candidates** (voir plus bas)) ou bien créées artificiellement. 

- Souvent les entreprises ont une méthode à suivre pour leurs tables selon les bases de données. Par exemple, on peut imposer les clés auto-incrémentées ou les UUID par exemple.

### Clés primaires artificielles

#### UUID
 Les UUID (Universally Unique Identifier) sont des identifiants uniques  de 128 bits en hexadécimal. Ils sont utilisés pour augmenter la sécurité de l'identifiant unique. Le format ressemble à ceci:
 ```
 550e8400-e29b-41d4-a716-446655440000
```

 Il en existe plusieurs types, mais elles sont conçues pour être 
 - aléatoire
 - difficile à prédire
 - unique globalement (pas seulement dans la BD locale)


Exemple de script SQL (Primary key auto-incrémentée).

> Note importante: chaque script de BD devra être exécutable à répétition, sans erreur.

```sql
-- Création de la table Client avec une clé primaire
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'clients')
BEGIN
    CREATE TABLE clients (
        id_client INT PRIMARY KEY IDENTITY(1,1), -- Auto-incémentation de l'id à chaque ajout
        nom VARCHAR(100) NOT NULL,
        email VARCHAR(150) UNIQUE NOT NULL -- Unique, mais pas primaire
    );
END
ELSE
BEGIN
	Print('Table déjà existante'); -- suggestion de message, c'est facultatif
END
```

Exemple de script SQL (Primary key UUID)

```sql
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'utilisateurs')
BEGIN
	CREATE TABLE utilisateurs (
		id_utilisateur UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
		nom NVARCHAR(100) NOT NULL,
		email NVARCHAR(255) UNIQUE NOT NULL
	);
END
```

### Clés primaires naturelles

Une clé naturelle est choisie parmi les champs déjà présents. On réfléchit d'abord aux clés candidates et on en désigne une comme clé primaire. Les clés non-choisies auront la mention UNIQUE. Cette étape est donc à faire même si on ne choisit pas l'approche de clé naturelle.

### Clés candidates

Une clé candidate est un attribut (ou un ensemble d’attributs) d’une table qui peut identifier chaque enregistrement de manière **UNIQUE**. C'est une candidature à devenir la clé primaire.

- Unicité : Chaque valeur de la clé candidate est unique dans la table.

- Non-réductibilité (Minimalité) : Aucun sous-ensemble des colonnes de la clé candidate ne peut toujours être unique.

- Intégrité : Elle doit garantir l’identification des enregistrements sans ambiguïté.

- Une clé candidate est une potentielle clé primaire, mais toutes ne sont pas nécessairement choisies.

- La clé primaire est UNE seule clé candidate désignée pour identifier les enregistrements.

- Les autres clés candidates peuvent être déclarées comme clés uniques (UNIQUE en SQL).

### Exemple

Dans la table des employés ci-dessous, quelle serait la ou les clés candidates?

| id_employe | NAS (Numéro d'assurance sociale) | email                         | nom      | téléphone|
|------------|----------------------------------|-------------------------------|---------|----|
| 1          | 123-456-789                     | jean.dubois@email.com         | Dubois  | 555-555-5555|
| 2          | 987-654-321                     | sophie.tremblay@email.com     | Tremblay | 888-888-8888|


### Clés composées

Une clé composée (ou clé composite) est une clé constituée de plusieurs colonnes qui, ensemble, assurent l’unicité de chaque ligne d’une table. Cela signifie qu’aucune colonne seule ne peut garantir cette unicité, mais leur combinaison le peut. Si une clé primaire est formée de plusieurs colonnes, alors on parle de **clé primaire composée**.

Exemple de script SQL

```sql
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'inscriptions')
BEGIN
    CREATE TABLE inscriptions (
        id_etudiant INT,
        id_cours INT,
        date_inscription DATE,
        PRIMARY KEY (id_etudiant, id_cours) -- Clé primaire composée
    );
END
```
<br>
<br>
<br>

[Exercices clé primaires](#03_Exercices_primaires.md)

## Clé étrangère

Une clé étrangère est une contrainte en SQL qui établit une relation entre deux tables. Elle permet d'assurer l'intégrité référentielle en liant une colonne d’une table à la clé primaire d’une autre table.

### Objectif d’une clé étrangère

- Garantir la cohérence des données : Une valeur de clé étrangère doit exister dans la table référencée.

- Éviter les incohérences : Empêche la suppression d’un enregistrement référencé par une autre table (sauf si une action spécifique est définie, comme CASCADE).



Exemple de script SQL (Foreign key)
```sql
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'clients')
BEGIN
    CREATE TABLE clients (
        id_client INT PRIMARY KEY,
        nom VARCHAR(100) NOT NULL
    );
END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'commandes')
BEGIN
    CREATE TABLE commandes (
        id_commande INT PRIMARY KEY IDENTITY(1,1),
        id_client INT, 
        date_commande DATE NOT NULL,
        montant_total DECIMAL(10,2) NOT NULL,
        CONSTRAINT fk_commandes_clients FOREIGN KEY (id_client) REFERENCES clients(id_client) 
    );
END
```
- La table clients contient une clé primaire id_client.

- La table commandes possède une clé étrangère id_client, qui fait référence à id_client dans clients.

- Un id_client inséré dans commandes doit exister dans clients.


### Actions sur les clés étrangères

Lors de la suppression ou mise à jour d’une clé primaire, vous pouvez définir des actions :

- CASCADE : lors de la suppression ou la modification de l'id du parent, les enregistrements qui font référence à ce parent sont effacés ou mis à jour (DELETE ou UPDATE)
- SET NULL: lors de la suppression du parent, le champs qui réfère à la clé parent est mise à NULL (DELETE ou UPDATE)
- RESTRICT (par défaut): Lorsqu'on essaie de supprimer le parent, un mécanisme nous en empêche.

Pour les ajouter ou les modifier après la création de la table, utiliser ALTER TABLE.

Préparez un script pour effacer les tables pour mieux recommencer si nécessaire.


