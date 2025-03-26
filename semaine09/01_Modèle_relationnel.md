# Modèle relationnel de données (MRD)

Le modèle relationnel de données est un paradigme utilisé pour organiser et structurer des données sous forme de tables interreliées. Il a été introduit par Edgar F. Codd en 1970 et constitue la base des bases de données relationnelles modernes comme MySQL, PostgreSQL, SQLite et SQL Server.

## Principes fondamentaux du MRD

- **Tables** : Les données sont stockées sous forme de tables (relations) composées de lignes (enregistrements) et de colonnes (attributs ou champs).

- **Clés** primaires et étrangères :

    - Une clé primaire (Primary Key) est un identifiant unique pour chaque ligne d'une table.
    - Une clé étrangère (Foreign Key) est un lien entre une table et une autre.

- **Intégrité référentielle** : Assure la cohérence entre les relations (par exemple, une clé étrangère ne peut pas référencer une entrée inexistante).

- **Langage SQL** : On utilise SQL (Structured Query Language) pour interroger et manipuler les données.

## Avantages du MRD

- Structure claire : Facile à organiser avec des relations bien définies.
- Intégrité des données : Grâce aux contraintes (clés primaires, étrangères).
- Flexibilité et scalabilité : Convient aux bases de données de grande envergure.
- Utilisation universelle : Supporté par de nombreux systèmes de gestion de bases de données

### Exercice
Il peut sembler simple de faire un MRD, mais il y a une multitude de choses auxquelles il faut penser... Par exemple, faisons le MRD dans draw.io qui s'appliquerait à un logiciel simple de bibliothèque... 

Quelles sont les entités? Les relations entre elles? Quels champs mettre dans les tables? Quelles sont les multiplicités? Quel type de variable utiliser? Ça a l'air simple, mais en réalité, il y a beaucoup de techniques à appliquer pour s'assurer que tout fonctionne et respecte l'intégrité des données!

Il faudra décortiquer tout ça et revenir faire un modèle relationnel de données avec plus de confiance!

## Propriétés ACID du SGBDR

Le système de gestion de bases de données relationnelles est aussi un acteur clé dans les transactions. Quatre propriétés essentielles définissent les **transactions** des bases de données relationnelles : atomicité, cohérence, isolement et durabilité, généralement appelées ACID.

- **Atomicité**: définit tous les éléments constituant une transaction de base de données complète. C'est "tout ou rien"

    - Exemple : Transfert bancaire
        - Si Alice envoie 100 $ à Bob :
        - La somme est retirée du compte d’Alice
        - La somme est ajoutée au compte de Bob

        Si une panne survient après l’étape 1 mais avant l’étape 2, la transaction est annulée pour éviter une perte d’argent.

        💡 Mécanisme utilisé : Les bases de données utilisent des **journaux de transactions** (logs) pour restaurer l’état initial en cas d’échec.

- **Cohérence**: définit les règles permettant de maintenir les points de données dans un état correct après une transaction.

    - Exemple : Stock d’un produit
        - Si un e-commerce vend un article, la quantité disponible doit être mise à jour et ne jamais être négative.
        - Si le stock est à 1 et qu’un client achète :
        - Avant la transaction : Stock = 1
        - Après la transaction : Stock = 0

        Il est impossible que le stock devienne -1.

        💡 Mécanisme utilisé : Contraintes d’intégrité (PRIMARY KEY, FOREIGN KEY, CHECK, NOT NULL).

- **Isolement**: conserve l’effet d’une transaction invisible aux autres jusqu’à ce que son engagement soit effectif, afin d’éviter toute confusion.

    - Exemple : Deux clients achètent le dernier article en stock
        - Le stock est 1.
        - Deux transactions (Client A et Client B) démarrent en même temps.
        - Sans isolation, les deux transactions peuvent voir le stock à 1 et valider l’achat… 
        - Résultat : Stock négatif

        💡 Solution : Les bases de données utilisent des niveaux d'isolation (READ COMMITTED, REPEATABLE READ, SERIALIZABLE) pour éviter ces conflits.

- **Durabilité**: garantit que les modifications de données deviennent permanentes une fois que l’engagement de la transaction est effectif.
    - Exemple : Paiement validé
        - Si un client effectue un paiement et que la base de données valide la transaction, elle doit être enregistrée définitivement.
        - Même si le serveur plante juste après, la transaction ne peut pas être perdue.

        💡 Mécanisme utilisé : Systèmes de journaux de transactions (Write-Ahead Logging, WAL) pour restaurer les données après une panne.






## Ressources:
- https://www.oracle.com/ca-fr/database/what-is-a-relational-database/ 