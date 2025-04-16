# TRIGGER

Un trigger est une commande qui est déclenchée au niveau de la BD

| Raisons d’utiliser un TRIGGER     | Explication |
|----------------------------------|-------------|
| **Centralisation de la logique** | La logique métier est exécutée dans la BD, ce qui assure qu'elle est toujours appliquée peu importe l'application ou le langage qui accède à la BD. |
| **Automatisation**               | Permet de déclencher automatiquement une action (ex. : mise à jour d’un historique, validation, synchronisation) sans coder cette action à chaque fois. |
| **Sécurité**                     | Évite que la logique soit contournée par une erreur ou un oubli dans l'application. |
| **Performance (parfois)**        | Exécuté côté serveur, donc évite les allers-retours avec le client. |
| **Maintenance**                  | Moins de duplication de code, plus facile à modifier dans un seul endroit. |


[Trigger en SQL server](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-trigger-transact-sql?view=sql-server-ver16)


Dans SQL Server, contrairement à d'autres scripts de programmation, il n'est pas possible de faire une action BEFORE insert. On peut alors s'en sortir autrement. Voir une solution dans le script de tickets!

# UNIQUE
La contrainte UNIQUE sert à empêcher les doublons dans une colonne ou un groupe de colonnes d’une table.

Elle garantit que chaque valeur est différente (comme une clé primaire, mais sans être forcément la clé de la table).

```sql
CREATE TABLE Employes (
    id INT PRIMARY KEY,
    matricule VARCHAR(10) UNIQUE,
    nom VARCHAR(50)
);
```

ou bien après la création:
```sql
ALTER TABLE Employes
ADD CONSTRAINT uq_matricule UNIQUE (matricule);
```
Possible sur plusieurs colonnes:
```sql
CREATE TABLE Inscriptions (
    id INT PRIMARY KEY,
    id_etudiant INT,
    id_cours INT,
    CONSTRAINT uq_etudiant_cours UNIQUE (id_etudiant, id_cours)
);
```
Bon à savoir:
- Une colonne UNIQUE peut contenir un seul NULL (car NULL ≠ NULL, donc pas vu comme doublon).

- Il est possible d'avoir plusieurs contraintes UNIQUE dans une même table (contrairement à PRIMARY KEY).

- UNIQUE crée automatiquement un index pour optimiser la recherche.

# CHECK

Une contrainte CHECK sert à valider les données avant qu'elles ne soient insérées ou modifiées dans une table.

Elle permet de restreindre les valeurs acceptées dans une colonne ou un ensemble de colonnes selon une condition logique.

```sql
CREATE TABLE Produits (
    id INT PRIMARY KEY,
    nom VARCHAR(50),
    prix DECIMAL(10,2) CHECK (prix >= 0)
);
```
ou bien après la création

```sql
ALTER TABLE Produits
ADD CONSTRAINT chk_prix_valide CHECK (prix >= 0);
```

Règles:
- Les valeurs NULL ne sont jamais testées dans une contrainte CHECK. Donc une ligne avec prix = NULL passe même si prix >= 0 est spécifié.

- La contrainte peut inclure :
    - Des opérateurs : =, <>, <, >, <=, >=
    - Des expressions logiques : AND, OR, NOT
    - Des références à d'autres colonnes de la même ligne (mais pas d'autres tables !)

- Pas de jointure
- Pas de sous-requête




