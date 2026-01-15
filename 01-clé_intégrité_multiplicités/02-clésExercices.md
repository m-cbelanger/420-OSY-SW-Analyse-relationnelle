# Exercices clés primaires





## Question 1

Voici des champs quelconques. Dites s’il s’agit de bons candidats pour former une clé primaire (PK). Indiquez si la clé peut être seule ou composée, et à quelle condition.

- nom_client
- prenom_client
- numero_telephone
- email
- adresse
- numero_facture
- numéro_succursale
- mode_paiement
- numero_carte_credit
- date_facture
- numéro_caisse


## Question 2

Voici les champs d’une table qui n’est pas normalisée. La table servira à faire l’inventaire des animaux à la SPA du quartier

-	nom_animal
-   id_propriétaire
-	espece (chat, chien, furet, lapin, etc.)
-	race (bouvier, siamois, « race de lapin », etc.)
-	pellage_couleur
-	pellage_longueur
-	poids
-	temperament
-	vaccins_obtenus
-	age_adoption
-	numero_medaille

a)	Quelles serait la ou les clés candidates pour être la clé primaire de cette table animaux?

b)	Pourquoi l’age serait un mauvais choix dans une clé primaire composée?


## Question 3

Contexte de vols d'avion. Un vol est un code qui précise la route effectuée par un avion. Par exemple, le vol AC123 part de Montréal vers Toronto.

```sql
CREATE OR REPLACE TABLE vols (
    numero_vol VARCHAR(10),
    date_depart_prevue DATE,
    date_depart DATETIME,
    retard TIME,
    statut_vol VARCHAR(50),
    destination VARCHAR(50)
);
```

a) Quelle serait la clé primaire naturelle de cette table? 

b) Est-ce qu'on devrait mettre une PK artificielle? Si oui, quel type?

c) On a aussi des réservations:

```sql
CREATE OR REPLACE TABLE reservations (
    nom_passager VARCHAR(100), 
    numero_carte_credit VARCHAR(20),
    paiement_complete BOOLEAN
    date_reservation DATE
);
```

a) Comment attacher efficacement cette table à la table vol?

b) Que suggérez-vous comme PK dans cette table?

c) Quel comportement devrait-on donner à la FK si le parent est modifié ou supprimé?

## Question 4

Supposons 2 tables, une de commandes et une de clients. 

a) Laquelle est "l'enfant" et laquelle est le "parent"?

b) Où irait la FK? Quelle champs proposez-vous pour attacher ces tables? Fournir les PK dans les 2 tables et les FK dans la ou les tables appropriées.

c) Lors de la suppression (delete) ou de la mise à jour (update) d'une ligne parent, on souhaite quoi comme comportement chez l'enfant?


## Question 5

Une table dans une base de données qui identifie les actifs de la ville (équipement, bâtiments, accessoires, etc.) a été construite il y a quelque temps et contient plusieurs centaines de lignes. Il a été choisi à l'époque de donner un id artificiel à chacun de ces actifs. 

On se rend compte, après quelque temps, que la base de données qui contient les parcs était à part, elle aussi contenant un id auto-incrémenté pour identifier les actifs. On souhaite ajouter tous les parcs à la BD initiale d'actifs. 

Expliquer pourquoi:

a) faire une insertion direct des données telle quel ne fonctionnerait pas (imaginez les problèmes et embuches potentielles).

b) modifier l'id d'une des tables en ajoutant une lettre au début du chiffre pour éviter les collisions ne fonctionnerait pas (imaginez les problèmes et embuches potentielles).

## Question 6
### Vrai ou Faux

1) Une clé primaire doit toujours avoir un sens métier

2) Une clé naturelle peut devenir une mauvaise clé primaire

3) Les UUID sont toujours le meilleur choix

4) Une clé primaire ne devrait jamais changer

5) Une clé primaire peut être utilisée comme clé étrangère