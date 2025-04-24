# Révision

Une équipe de production souhaite mettre en place une base de données pour gérer le tournage des scènes d’une série télévisée. Chaque scène est planifiée à une date précise. Elle possède une description, une durée estimée (en minutes) et un identifiant unique. Les scènes sont tournées dans des lieux de tournage. Chaque lieu possède un code de lieu unique, une adresse complète, et un type de lieu (intérieur, extérieur, studio, etc.). Un même lieu peut être utilisé pour tourner plusieurs scènes, à des dates différentes.

Chaque scène nécessite la présence d’un ou plusieurs acteurs. Les acteurs sont identifiés par un numéro d’acteur unique, un nom, et le rôle qu’ils jouent dans la série (ex. : Inspecteur, Méchant, Voisin curieux, etc.). Un acteur peut participer à plusieurs scènes différentes.

### Voici quelques exemples :

Le 3 mai, la scène 12 « confrontation sur le toit » (durée : 15 minutes) est tournée au studio principal (code ST01). Elle inclut les acteurs Jean (acteur 101, rôle : Inspecteur) et Zoé (acteur 102, rôle : Méchante).

Le 4 mai, la scène 13 « explosion au port » (durée : 10 minutes) est tournée au port industriel (code EXT03). Elle fait intervenir Jean (acteur 101) et Patrick (acteur 103, rôle : Collègue maladroit).

Le 5 mai, la scène 14 « retour à la maison » (durée : 8 minutes) est tournée dans une maison réelle (code EXT05), avec Zoé (acteur 102) seulement.

Travail demandé:

- Modéliser la situation en schéma de tables (modèle relationnel de données – MRD).
- Indiquez les colonnes de chaque table, leurs types de données et les contraintes (PK, FK, UNIQUE).
- N’insérez aucune valeur.
- S’il y a lieu, ajoutez des tables de liaison.
- Indiquez clairement les multiplicités entre les entités (1..*, (0..* ou *), etc.).
- Vous devez être en mesure d'identifier vos choix

- Si on voulait ajouter le nombre de prise pour chaque acteur et scènes, on ajouterait ça où?
- Si on veut faire une lookup table, on la met où, avec quoi dedans?