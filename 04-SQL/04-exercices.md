# Exercices SQL - > CRUD et sauvegarde du prix

## Question 1

En vous fiant au MRD suivant:

![](img/pensions_animaux4.png)

a) Faire le script SQL de création des tables.
b) Utilisez le seed suivant:

```sql
-- seed



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

## Question 4

Que faudrait-il ajouter pour faire une facture? Faites l'ajout DANS UN NOUVEAU SCRIPT (on ne doit pas drop les tables déjà existantes).

Présenter les données et les calculs à faire pour facturer les clients.
