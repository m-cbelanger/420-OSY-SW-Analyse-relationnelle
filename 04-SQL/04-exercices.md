# Exercices SQL - > CRUD et sauvegarde du prix

## Question 1

En vous fiant au MRD suivant:

![](img/pensions_animaux4.png)

a) Faire le script SQL de création des tables.
b) Utilisez le seed suivant:

```sql
-- seed

-- ======================
-- CLIENTS
-- ======================
INSERT INTO clients (name, phone, email) VALUES
('Jean Tremblay', '514-555-1234', 'jean.tremblay@email.com'),
('Marie Gagnon', '438-555-5678', 'marie.gagnon@email.com'),
('Luc Bouchard', '514-555-8899', 'luc.bouchard@email.com'),
('Sophie Roy', '450-555-2222', 'sophie.roy@email.com'),
('David Pelletier', '514-555-7777', 'david.pelletier@email.com'),
('Caroline Lavoie', '438-555-1111', null);

-- ======================
-- EMPLOYEES
-- ======================
INSERT INTO employees (name, phone, email, hired_date, termination_date) VALUES
('Karine Dubois', '514-555-1112', 'karine.dubois@pension.com', '2022-03-10', NULL),
('Marc Lavoie', '514-555-2223', 'marc.lavoie@pension.com', '2021-07-15', NULL),
('Julie Morin', '438-555-3333', 'julie.morin@pension.com', '2023-01-20', NULL),
('Patrick Gauthier', '450-555-4444', 'patrick.gauthier@pension.com', '2026-03-01', NULL);

-- ======================
-- KENNELS (CAGES)
-- ======================
INSERT INTO kennels (code, capacity, detail, is_available) VALUES
('ABC', 2, 'avec étages', 1),
('DEF', 4, 'avec faux gazon', 1),
('GHI', 1, 'modules inclus', 1),
('JKL', 2, 'avec jouet et faux gazon', 1),
('MNO', 3, 'près de aire commune', 1),
('PQR', 1, 'près de aire commune', 1),
('STU', 2, 'faux gazon', 1),
('VWX', 1, 'isolement', 1),
('ZZZ', 2, 'réserve', 1);

-- ======================
-- ANIMALS
-- ======================
INSERT INTO animals (name, specie, breed, color, food_quantity, meals_per_day, takes_med, comment, id_client) VALUES
('Rex', 'chien', 'Berger Allemand', 'brun et noir', 2.50, 2, 0, 'Très énergique', 1),
('Charlie', 'chien', 'Golden Retriever', 'doré', 2.80, 2, 0, 'Très amical', 1),
('Mimi', 'chat', 'Siamois', 'crème', 0.30, 2, 0, 'Aime dormir au soleil', 2),
('Minou', 'chat', 'Domestique', 'gris', 0.25, 2, 0, 'Très calme', 3),
('Bella', 'chien', 'Caniche', 'blanc', 1.20, 2, 1, 'Médicament pour allergies', 4),
('Coco', 'petit_animal', 'lapin nain', 'blanc', 0.15, 2, 0, NULL, 5),
('Pitou', 'chien', 'Labrador', 'noir', 3.00, 2, 0, 'Adore jouer à la balle', 6),
('Bella', 'chien', 'Teckel', 'brun', 1.20, 2, 1, 'Agressif avec les autres chiens', 6);

-- ======================
-- BOARDINGS (Réservations)
-- ======================
INSERT INTO boardings (arrival_date, departure_date, id_employee, code_kennel) VALUES
('2026-03-01', '2026-03-05', 1, 'ABC'),
('2026-03-06', '2026-03-10', 3, 'JKL'),
('2026-03-10', '2026-03-14', 3, 'DEF'),
('2026-03-14', '2026-03-18', 2, 'STU'),
('2026-03-15', '2026-03-19', 2, 'GHI'),
('2026-03-16', '2026-03-20', 3, 'ABC'),
('2026-03-18', '2026-03-22', 1, 'DEF'),
('2026-03-22', '2026-03-26', 2, 'GHI'),
('2026-03-26', '2026-03-30', 2, 'MNO'),
('2026-04-01', '2026-04-05', 3, 'PQR'),
('2026-04-05', '2026-04-09', 1, 'STU'),
('2026-04-10', '2026-04-14', 2, 'ABC'),
('2026-04-20', '2026-04-24', 3, 'DEF'),
('2026-04-20', '2026-04-24', 1, 'GHI');

-- ======================
-- BOARDINGS_ANIMALS (Assignation animaux aux réservations)
-- ======================
INSERT INTO boardings_animals (id_boarding, id_animal) VALUES
(1,1),  
(1,2),  
(2,3),
(2,4),  
(3,5),  
(3,7),  
(4,6),  
(5,7),
(5,8),
(6,1),  
(6,2),  
(7,5),  
(7,8),  
(8,7),  
(9,4),  
(10,3), 
(11,6), 
(12,1), 
(13,5), 
(14,7); 

```



Pour chacune des sous-questions suivantes, déclarez des variables pour prendre les informations. Cela rend vos scripts dynamiques. Par exemple:

```sql
declare @nom varchar(255) = 'Kevin Fournier'
declare @numero varchar(20) = '819-111-5555'

insert into clients (name, phone, email)
values(@nom,@numero, null)
GO
```

c) CREATE (ne pas oublier les variables)

Les variables simulent que la prise des infos se fait dans une interface quelconque. Oui vous êtes obligés de le faire :P

- Faire la création d'un nouvel élément dans une des 4 tables suivantes: clients, animals, employees, kennels. Mettre un GO pour délimiter le batch (ça rend les variables inaccessibles dans les autres batch)
- Faire la création d'un nouveau boarding pour tous les animaux de Jean Tremblay du 1er mai 2026 au 5 mai 2026, enregistré par l'employé Marc Lavoie. Les animaux seront dans la cage ABC 

d) READ (ne pas oublier les variables)
- Montrez les réservation en incluant le nom de la personne qui réserve, son ou ses animaux (dans une même case, avec STRING_AGG (au lieu de group_concat)), la date d'arrivée et de départ et l'enclos.
- Comment modifier cette présentation pour montrer les informations de la réservation créée au tiret précédent seulement.

e) UPDATE (ne pas oublier les variables)
- Jean Tremblay adopte le caniche Bella de Sophie Roy. Modifiez cette information en BD et assurez-vous que le caniche est ajouté à la pension du 1er mai prochain. Vos variables connues sont les noms des clients et du chien. Vous devez vous servir des info connues pour chercher le ou les id manquants et les mettre dans une variable.
- Julie Morin quitte son emploi. Toutes ses réservations futures doivent être transférées à Patrick Gauthier. Faire toutes les modifications nécessaires pour que les données soient intègres.

f) DELETE (ne pas oublier les variables)
- Dans la réservation de Jean, enlever le chien Charlie
- annuler la réservation du 20 avril 2026 pour Caroline Lavoie, elle ne part plus en voyage.
  

## Question 2

On fait un batch (script qui se déclenche seul à l'aide d'un service) qui roule chaque nuit à 00:01 et qui change le booléen de disponibilité dans la BD. Faites ce script à part pour que les disponibilités de kennels tournent à 0 si on est en plein coeur d'une réservation. Assurez-vous que vous avez des données pour tester votre script.

## Question 3

On veut ajouter le prix de location des enclos (par animal, par jour). DANS UN NOUVEAU SCRIPT (on ne doit pas drop les tables déjà existantes), ajouter la ou les colonnes nécessaires pour que le prix des enclos se gardent en BD dans le but éventuel de faire une facture. Pensez à la conservation des prix en prévision d'une possible fluctuation.

La tâche consiste, SANS modifier la création de table précédente, à 
- ajouter la colonne de prix et la colonne pour historiser le prix 
- remplir les valeurs à 15 partout sauf pour le enclos ABC, DEF et GHI, ils sont à 25
- Ne laisser aucun prix à Null

La création d'un boarding est à la Q4

## Question 4

Que faudrait-il ajouter pour faire une facture? Faites l'ajout DANS UN NOUVEAU SCRIPT (on ne doit pas drop les tables déjà existantes).

Présenter les données et les calculs à faire pour facturer les clients. Présentez le CRUD également, en utilisant les variables qui simulent les valeurs entrées dans un formulaire.
