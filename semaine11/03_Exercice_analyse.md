# Modélisation de base de données: Exercice

Situation :

Vous avez un propriétaire de pension pour animaux qui vous demande de schématiser une application pour gérer sa petite entreprise. Il veut pouvoir garder les informations sur les animaux qui profiterons de la pension chez eux (nom, espèce, race, couleur, quantité de nourriture par repas, nombre de repas par jour, la prise ou non de médicament au moment de la pension, etc.). Les informations sur la pension elle-même doivent aussi être pris en considération. Les animaux sont mis dans des enclos la nuit et les enclos ont un code alphanumérique. Ils peuvent être seuls dans l’enclos ou bien être mis en pension avec d’autres animaux. La capacité des enclos est de 4 animaux maximum. On veut garder une trace de quel employé a entré la réservation. L’employé va prendre en note la date d’arrivée, la date de départ et les informations du client qui est propriétaire de l’animal ou des animaux.

> Note : certains champs sont à déduire de votre côté pour assurer au propriétaire de l’entreprise de pension qu’il aura assez d’information sur ses pensionnaires et leur maîtres.

## Question 1

Faire le modèle relationnel des données. Celui-ci inclut:
- le schéma des tables sur draw.io, avec les titres et les champs
- les liens entre les tables avec la multiplicité à chaque bout
- les champs avec leur TYPE et leur spécificité (UNIQUE, NOT NULL, etc.)
- les PK et FK
- les tables de liaison s'il y a lieu


## Question 2

Faire le script de création de BD de cette situation. 
- ne pas laisser de drop dans le script final (utiliser un script à part en développement si vous droppez)
- Faire attention à l'ordre de création
- Inventez quelques insertions
