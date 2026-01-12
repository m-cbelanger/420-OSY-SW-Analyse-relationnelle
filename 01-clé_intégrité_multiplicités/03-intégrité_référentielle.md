# Intégrité référentielle

- L’intégrité référentielle fait référence à l’exactitude et la consistance des données dans une relation. On veut que, peu importe où on fouille dans les tables, on aura la donnée exacte, intacte, atomique. 
- Dans les relations, les données sont liées entre deux ou plusieurs tables. Pour ce faire, la clé étrangère (dans la table associée) fait référence à une valeur de clé primaire (dans la table principale ou parent). Pour cette raison, nous devons nous assurer que les données des deux côtés de la relation restent intactes.
- Ainsi, l'intégrité référentielle exige que, chaque fois qu'une valeur de clé étrangère est utilisée, elle doit référencer une clé primaire valide et existante dans la table parent.

### Exemple

![intégrité](img/intégrité.png)

    Par exemple, si nous supprimons la ligne numéro 15 dans une table primaire, nous devons nous assurer qu'il n'y a pas de clé étrangère dans aucune table associée avec la valeur 15. Nous ne devrions pouvoir supprimer une clé primaire que s'il n'y a pas de lignes associées. Sinon, nous nous retrouverions avec un enregistrement orphelin.

    On ne pourrais pas non plus insérer une nouvelle ligne dans la table "related table" qui contient un CompanyId différent de 1 ou 2.


L'intégrité référentielle empêchera donc les utilisateurs de:
- Ajouter de lignes à une table associée s'il n'y a pas de ligne associée dans la table primaire. 
- Modifier des valeurs dans une table principale qui entraînent des enregistrements orphelins dans une table associée.
- Supprimer des lignes d'une table principale s'il existe des lignes associées correspondantes.

### Protection de l'intégrité

Pour renforcer l’intégrité référentielle on peut utiliser les méthodes indiquées ci-dessous:

- Empêcher l’utilisateur de modifier la clé primaire
- Éviter la suppression d’un enregistrement parent s’il possède des enfants ou imposer un comportement comme SET NULL ou CASCADE
- Appliquer les principes de la normalisation (à voir très bientôt) pour éviter le dédoublement d'information.


# Anomalies dans les SGBD

Il existe trois types d'anomalies qui peuvent mettre en péril l'intégrité référentielle.
- Anomalie d'insertion, 
- Anomalie de mise à jour 
- Anomalie de suppression

Prenons un exemple pour comprendre
Supposons qu’une entreprise de fabrication stocke les détails de l’employé dans une table nommée `employee` qui possède quatre attributs
- `id` pour stocker l’identifiant de l’employé
- `emp_name` pour stocker le nom de l’employé
- `emp_address` pour stocker l’adresse de l’employé
- `emp_dept` pour stocker les détails du service dans lequel travaille l’employé

Voici la table:

![table1](img/employee.png)

La table n’est pas normalisée (donc si les tables ne sont pas découpées correctement), nous allons voir les problèmes que cela peut engendrer.

1. Anomalie de mise à jour:

    - Nous avons deux lignes pour l'employé Rick car il appartient à deux départements.
    - Si nous voulons mettre à jour l'adresse de Rick, nous devons mettre à jour la même chose sur deux lignes ou les données deviendront incohérentes.
    - Si d'une manière ou d'une autre, l'adresse correcte est mise à jour dans un département mais pas dans un autre, selon la base de données, Rick aurait deux adresses différentes, ce qui n'est pas correct et entraînerait des données incohérentes. (Si on cherche l'adresse de Rick, on ne doit pas avoir 2 réponses différentes si on fouille à une place plutôt que l'autre)

2. Anomalie d’insertion (FK impliquées)

    - Supposons que l’on embauche un nouvel employé qui est en formation et qui n’est pas assigné à un département
    - Si l’attribut « emp_dept » ne permet pas les valeurs nulles, il ne sera pas possible d’ajouter l’enregistrement (c'est une bonne chose, on ne veut pas de gens associé à nulle part!)


3. Anomalie de suppression
   
    - Supposons qu’il y a une restructuration dans l’entreprise et que l’on décide de fermer le département D890
    - En supprimant le département D890, on supprime aussi les informations de Maggie, car c’est le seul département où elle est assignée. Si on laisse ça comme ça, il faudrait chercher chaque ligne de la table et modifier le nom du département? Comment intégrer ça dans une application? Comment s'assurer qu'il n'y a pas d'oubli? Et que le nom du département ne se trouve pas dans d'autres tables?

On ajoute à tout cela que si on décidait de faire une seule grosse table avec toutes les infos sans découper en tables distinctes, on se retrouverait avec une table extrêmement lourde avec des doublons (prend plus de place, mise à jour risquées, laisse place aux incohérence). En plus des problèmes de stockage, ça peut amener des problèmes de performance à long terme.