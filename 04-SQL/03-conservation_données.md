# Conserver les données

Nous avons vu à plusieurs reprises des MRD avec des tables et on a toujours pris pour acquis que les données étaient fixes dans le temps.

Par contre, certaines valeurs fluctuent dans le temps, et on souhaite garder une trace de l'évolution de ces infos...pensons à une facture, si le prix d'un article change? Un employé qui change d'échelon salarial? De département?

### Par exemple: 

On a un modèle réduit de factures et items:

```sql
-- création des tables, attention à l'ordre
drop table if exists items_factures;
drop table if exists factures;
drop table if exists items;

create table items(
	id int identity(1,1) primary key,
	nom varchar(100),
	prix decimal(10,2)
);

create table factures(
	id int identity(1,1) primary key,
	date date default getdate()
);

create table items_factures(
	id_facture int,
	id_item int,
	PRIMARY KEY (id_facture,id_item),
	FOREIGN KEY (id_facture) REFERENCES factures(id),
	FOREIGN KEY (id_item) REFERENCES items(id)
);

-- seed
insert into items (nom, prix)
values ('soupe', 4.23), 
('lasagne', 12.45), 
('souvlaki', 10),
('salade césar', 8.75),
('burger classique', 11.50),
('poutine', 9.95),
('pizza margherita', 13.25),
('sandwich club', 10.75),
('spaghetti bolognaise', 14.50),
('tacos au poulet', 12.00),
('riz frit', 9.25),
('wrap végétarien', 10.50),
('steak frites', 18.95),
('poisson pané', 15.25),
('quiche lorraine', 11.95);

insert into factures (date)
values ('2026-01-12'), ('2026-01-13'), ('2026-01-14'), ('2026-01-14'),('2026-01-15'), ('2026-01-16'),('2026-01-17'),('2026-01-18'),('2026-01-18'),('2026-01-19'),('2026-01-20'),('2026-01-21'),('2026-01-21'),('2026-01-22'),('2026-01-23'),('2026-01-24'),('2026-01-24'),('2026-01-25'),('2026-01-26'),('2026-01-27')

insert into items_factures (id_facture, id_item)
values
(1, 1), (1, 3), (1, 6), (1, 5),
(2, 2), (2, 4),
(3, 5), (3, 6), (3, 10),
(4, 8), (4, 9),
(5, 7), (5, 12),
(6, 11), (6, 4),
(7, 13), (7, 1),
(8, 14), (8, 4), (8, 6), (8, 10),
(9, 2), (9, 9),
(10, 5), (10, 15),
(11, 3), (11, 8),
(12, 7), (12, 6),
(13, 10), (13, 11),
(14, 13), (14, 4),
(15, 1), (15, 2), (15, 6),
(16, 12), (16, 9),
(17, 14), (17, 8),
(18, 5), (18, 7),
(19, 15), (19, 4),
(20, 3), (20, 6);
```

a) présentez avec une requête le prix total des factures du 14 janvier 2026 et une autre requête séparée avec le sommaire du total de toutes les factures.

b) le temps passe et le prix de la poutine devient 20$, le prix du tacos au poulet monte de 15% et le steak frite monte à 25 $. Faites le changement dans la BD.

c) il est maintenant temps de faire le sommaire des ventes et revenus. Réutilisez le script du sommaire des ventes pour le 14 janvier 2026. Que remarquez-vous?


## Une des solutions: copier les champs

Une des 2 solutions présentées dans ce cours est de copier le prix actuel dans un champs de la BD, dans la table de liaison:

```sql
drop table if exists items_factures;
drop table if exists factures;
drop table if exists items;

create table items(
	id int identity(1,1) primary key,
	nom varchar(100),
	prix decimal(10,2)
);

create table factures(
	id int identity(1,1) primary key,
	date date default getdate()
);

create table items_factures(
	id_facture int,
	id_item int,
	prix_paye decimal(10,2), -- ici, on ajoute la copie du prix
	PRIMARY KEY (id_facture,id_item),
	FOREIGN KEY (id_facture) REFERENCES factures(id),
	FOREIGN KEY (id_item) REFERENCES items(id)
);

-- pour ajuster les prix après l'ajout de la colonne prix_payes
update i_f
set i_f.prix_paye = i.prix
from items as i 
join items_factures as i_f on i_f.id_item = i.id
where i_f.prix_paye is null;
```

Après la création des tables, on aura à utiliser les tables pour régulièrement faire des actions avec le logiciel et garder les informations en BD. On doit pouvoir faire les interactions suivantes dans le logiciel:
- C: Create
- R: Read
- U: Update
- D: Delete

# Insérer des données (Create)

Dans le code, lors de la création d'une nouvelle facture, il faudrait que le script suivant s'exécute:

```sql
-- créer la facture:
insert into factures default values;

-- voir explications plus bas
declare @id_facture int;
set @id_facture = scope_identity();


-- insérer les 2 items dans items_factures. Le select dans l'insert servira à copier les informations.
insert into items_factures (id_facture, id_item, prix_paye)
select 
    @id_facture,
    id,
    prix
from items
where nom in ('riz frit','salade césar'); -- voir le dernier script de la page pour une version plus dynamique
```

La variable @id_facture sert à enregistrer la valeur retournée par SCOPE_IDENTITY(), c’est-à-dire l’identifiant (IDENTITY) de la dernière ligne qui vient d’être insérée dans ce script.

Il serait plus simple d'ajouter de nouveaux items, il suffit de faire un update sans interaction avec les autres tables

# Lire les données (Read)
- On peut maintenant faire un select pour voir les données insérées avec copies:

```sql

-- à vous de jouer!


```

# Supprimer des données (Delete)

Disons qu'on veuille supprimer un item de la facture numéro 12 par exemple. On veut remplacer la poutine par un burger classique.

```sql

-- à vous de jouer!


```


# Modifier les données (Update)

La modification du prix au début des notes est un bon exemple d'update:
```sql
update items 
set prix = 20
where nom = 'poutine'
;
update items
set prix = prix*1.15
where nom = 'tacos au poulet'
;
```

## Liste version plus dynamique
Si on souhaite rendre le tout dynamique pour l'ajout d'items provenant d'une liste (remplie dans le code). Une table variable (@nom_de_la_table) est valide dans le batch courant seulement (délimité par GO). Elle n'est pas sauvegardée dans la BD de manière permanente.

```sql
insert into factures default values;

declare @id_facture int;
set @id_facture = scope_identity();

-- On déclare la "liste" dans une table variable
DECLARE @items_choisis TABLE (nom VARCHAR(255));

-- On la remplit — c'est ici que l'application enverrait les choix de l'utilisateur, mais on la remplit pour la simulation
INSERT INTO @items_choisis VALUES ('riz frit'), ('salade césar');

-- On l'utilise dans le script
INSERT INTO items_factures (id_facture, id_item, prix_paye)
SELECT 
    @id_facture,
    i.id,
    i.prix
FROM items AS i
JOIN @items_choisis AS choix ON choix.nom = i.nom;


```