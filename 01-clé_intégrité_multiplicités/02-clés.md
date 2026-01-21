
Révisons les mécanismes du SGBDR mis en place pour assurer l'intégrité des données. Tout d'abord, les clés, leur rôle, leurs avantages.

# Clés (PK, FK)
- Vous connaissez deux types de clés, soit 
  - la clé primaire (Primary key) qui sert à identifier uniquement un enregistrement.
  - la clé étrangère (Foreign key) qui sert à identifier la correspondance vers enregistrement "parent" depuis la table "enfant".

- Les 2 types de clés peuvent être composées ou non.


### Clés composées

Une clé composée (ou clé composite) est une clé constituée de plusieurs colonnes qui, ensemble, identifie minimalement une ligne dans une table. Cela signifie qu’aucune colonne seule ne peut garantir cette unicité, mais leur combinaison le peut. Si une clé primaire est formée de plusieurs colonnes, alors on parle de **clé primaire composée**.

#### Exemple de script SQL

```sql
CREATE OR REPLACE TABLE inscriptions (
    id_etudiant INT,
    id_cours INT,
    date_inscription DATE,
    session varchar(5),
    PRIMARY KEY (id_etudiant, id_cours, session) -- Clé primaire composée
);

CREATE OR REPLACE TABLE evaluations (
    id_etudiant INT,
    id_cours INT,
    note INT,
    session varchar(5),
    PRIMARY KEY (id_etudiant, id_cours, session), -- Clé primaire composée

    FOREIGN KEY (id_etudiant, id_cours, session) REFERENCES inscriptions (id_etudiant, id_cours, session) -- Clé étrangère composée
);

```

## Clé primaire

La clé primaire est sélectionnée parmi les champs déjà présents (les clés **candidates** (voir plus bas)) ou bien créées artificiellement. 

- Souvent les entreprises ont une méthode à suivre pour leurs tables selon les bases de données. Par exemple, on peut imposer les clés auto-incrémentées ou les UUID par exemple.

### Clés primaires artificielles

#### Auto-incrément
Les clés artificielles déjà connues sont les PK auto_increment, qui vont automatiquement chercher le dernier nombre de la table et ajoutent un entier pour créer la nouvelle valeur unique.

Ce format est conçu pour être 
- simple
- facile à trouver
- léger et rapide à comparer

#### UUID
 Les UUID (Universally Unique Identifier) sont des identifiants uniques de 128 bits en hexadécimal. Ils sont utilisés pour augmenter la sécurité de l'identifiant unique. Le format ressemble à ceci:
 ```
 550e8400-e29b-41d4-a716-446655440000
```

 Il en existe plusieurs types, mais elles sont conçues pour être 
 - aléatoire
 - difficile à prédire
 - unique globalement (pas seulement dans la BD locale)

Selon vous, dans quel contexte peut-on vouloir utiliser un UUID plutôt qu'un auto-incrément et vice-versa?

#### Exemple de script SQL (Primary key auto-incrémentée).

```sql
-- Création de la table Client avec une clé primaire

CREATE OR REPLACE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL -- Unique, mais pas primaire
);

```

#### Exemple de script SQL (Primary key UUID)

```sql
CREATE OR REPLACE TABLE users (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);
```
### Clés primaires naturelles

Une clé naturelle est choisie parmi les champs déjà présents. On réfléchit d'abord aux clés candidates et on en désigne une comme clé primaire. Les clés non-choisies auront la mention UNIQUE. Cette étape est donc à faire même si on ne choisit pas l'approche de clé naturelle.

### Clés candidates

Une clé candidate est un champ (ou un ensemble de champs) d’une table qui peut identifier chaque enregistrement de manière **UNIQUE**. C'est une candidature à devenir la clé primaire.

- Unicité : Chaque valeur de la clé candidate est unique dans la table.

- Non-réductibilité (minimalité) : Aucun sous-ensemble des colonnes de la clé candidate ne peut toujours être unique.

- Intégrité : Elle doit garantir l’identification des enregistrements sans ambiguïté.

- Une clé candidate est une potentielle clé primaire, mais toutes ne sont pas nécessairement choisies.

- La clé primaire est UNE seule clé candidate désignée pour identifier les enregistrements.

- Les autres clés candidates peuvent être déclarées comme clés uniques (UNIQUE en SQL).

### Exemples

a) Dans la table des employés ci-dessous, quelle serait la ou les clés candidates?

| id | NAS | email                         | name      | phone|
|------------|----------------------------------|-------------------------------|---------|----|
| 1          | 123-456-789                     | jean.dubois@email.com         | Dubois  | 555-555-5555|
| 2          | 987-654-321                     | sophie.tremblay@email.com     | Tremblay | 888-888-8888|


b) Dans la table groups, quelle est la clé candidate naturelle?

groups
| number     | semester  | employee_id   | course_code      | 
|------------|-----------|---------------|------------------|
| 1          | A2025     | 1454          | 420-0Q4-SW       |
| 1          | A2025     | 1487          | 420-1Q2-SW       |
| 2          | A2025     | 1487          | 420-1Q2-SW       |
| 3          | A2025     | 1487          | 420-1Q2-SW       |
| 1          | A2025     | 1311          | 420-0Q7-SW       |

#### Exercice
Penser à toutes les combinaisons de valeurs à insérer, lesquelles devraient être permises? Voici le script partiel pour la création de cette table. Complétons la clé primaire et les contraintes d'unicité.

```sql
CREATE OR REPLACE TABLE groups (
    number TINYINT UNSIGNED NOT NULL DEFAULT 0,
    semester CHAR(5) NOT NULL,
    teacher_employee_number INT UNSIGNED NOT NULL,
    course_code CHAR(10) NOT NULL,
    
    ...

);
```

### Quel type de PK choisir?

Il n'y a pas de réponse unique à cette question, ça dépend du besoin.

La clé primaire artificielle auto-incrémentée a pour utilité d'être:
- stables (ne changent jamais)
- simples à utiliser pour les clés étrangères
- excellentes performances (surtout AUTO_INCREMENT)

La clé primaire artificielle de type UUID a pour utilité d'être:
- très sécuritaire (données sensibles qu'on souhaite non-prédictibles)
- unique à l'ensemble des tables et BD (but de fusion de BD, génération d'ID client)

La clé primaire naturelle est appropriée dans les cas où:
- le contenu des champs ne changera jamais ou presque (NAS, code iso (CAN, USA, etc.), code de cours, devises (CAD, USD, etc.)), tout autre mot invariable.

« Les clés naturelles expliquent le réel. Les clés artificielles facilitent la vie. »






## Clé étrangère

Une clé étrangère est une contrainte en SQL qui établit une relation entre deux tables. Elle permet d'assurer l'intégrité référentielle en liant une ou plusieurs colonnes d’une table à la clé primaire d’une autre table.

### Objectif d’une clé étrangère

- Garantir la cohérence des données : Une valeur de clé étrangère doit exister dans la table référencée.

- Éviter les incohérences : Empêche la suppression d’un enregistrement référencé par une autre table (sauf si une action spécifique est définie, comme CASCADE).


Exemple de script SQL (Foreign key)
```sql
CREATE OR REPLACE TABLE clients ( -- table "parent"
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE OR REPLACE TABLE commandes ( -- table "enfant"
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_client INT, 
    date_commande DATE NOT NULL,
    montant_total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_client) REFERENCES clients(id_client) 
);
```
- La table clients contient une clé primaire id.

- La table commandes possède une clé étrangère id_client, qui fait référence à id dans clients.

- Un id_client inséré dans commandes doit exister dans clients.

### Actions sur les clés étrangères

Lors de la suppression ou mise à jour d’une clé primaire, vous pouvez définir des actions :

- CASCADE : lors de la suppression ou la modification de l'id du parent, les enregistrements qui font référence à ce parent sont effacés ou mis à jour (DELETE ou UPDATE)
- SET NULL: lors de la suppression du parent, le champ qui réfère à la clé parent est mise à NULL (DELETE ou UPDATE)
- RESTRICT (par défaut): Lorsqu'on essaie de supprimer le parent, un mécanisme nous en empêche.

Pour les ajouter ou les modifier après la création de la table, utiliser ALTER TABLE.

### Pourquoi des clés étrangères?

Pourquoi se donner tant de mal à attacher correctement nos tables entre elles? C'est dans le but de respecter un principe PRIMORDIAL avec les SGBD: conserver l'INTÉGRITÉ RÉFÉRENTIELLE. 






