# TRAVAIL PRATIQUE 2 (15%)

## Réalisation
- Ce travail se fait individuellement
- Il y a des variantes possibles
- Il contient un MRD (modèle relationnel de données) avec draw.io et un script de création de BD avec SQL server (T-SQL)
- La date de remise est le **18 mai 2025 à 23h59** dans la section Travaux de Léa.
- Dans un fichier **.zip**, remettre:
    - un modèle relationnel de données (voir détails plus bas)
    - les 3 scripts décrits plus bas
- Il faudra prendre rendez-vous avec moi ensuite pour une rencontre de 15-20 minutes pour expliquer et valider les choix faits. Un fichier Excel partagé sera diffusé pour les plages horaires disponibles lorsque les horaires d'examens seront connus.


# Contexte


On continue de développer l'application de restauration du Casse-croûte chez MC. Vous avez une maquette de départ, le même pour tout le monde. J'ai pris celui de l'un d'entre vous que j'ai modifié un peu. On considère les tables à faire qui serait nécessaire à coder cette application. Voici quelques éléments intéressants à savoir:
- on considère les factures
    - la taxe reste simple et fixe à 15%
    - pas de rabais applicables
    - pas de carte fidélité
    - pas de coupon ou mode de paiement à gérer
    - pas besoin de gérer si oui ou non la facture est payée
- on considère les employés et leur qualifications:
    - serveur ou gérant
    - la facture peut être produite par la personne qui a servi la table ou par la gérante.
- chaque commande est associée à un client, qui est à une table à un moment précis. Quand la commande a un statut "facturé", on garde un historique de la commande. Le cuisinier n'a pas accès au logiciel, alors il ne peut pas mettre la commande à "prête" ou "terminée".
- les prix des items sont fictifs et laissés à votre discrétion. Limitez vous aux items mentionnés dans le TP1.
- il n'y a pas de distinctions entre les types de commandes (pas de livraison ou de `take out`)
- le code de connexion des serveuse peut être enregistré en clair dans la BD, même si en réalité ce n'est pas recommandé.


# Tâches
## MRD
Vous devez créer un MRD (modèle relationnel de données) avec l'outil draw.io. Les éléments suivants doivent être présents:
- tables et leurs noms
- champs, leur type et leurs contraintes (not null, default, etc.)
- liaisons et multiplicités (pas d'agrégation, composition ni héritage)
- si applicable, les tables de liaison
- présence de toutes les PK et FK

## Script
En T_SQL (SQL server), faire 3 scripts en tout:
- le script de création des tables dans une BD qui porte votre nom de famille et l'initiale de votre prénom (belanger_mc par exemple)
    - le script principal ne doit pas contenir de drop sur la BD ni les tables
    - il doit obligatoirement y avoir au moins un trigger, un check et un unique (autre qu'une PK). En mettre plusieurs si c'est jugé nécessaire. 
- le script de drop des tables, déclencheurs (Triggers) et autres contraintes, à part. (il est possible de drop les Trigger directement dans le script de création pour éviter les erreurs)
- le script d'insertion de données fictives inventées, incluant les select de présentation des tables et un update pour montrer le déclenchement du ou des trigger ou check. Le nombre d'insertion doit montrer minimalement les comportements attendus dans les tables lors de cas spéciaux. 


## Rencontre
Après la remise, une rencontre d'environ 15 minutes maximum sera demandée pour que je vous pose des questions sur l'élaboration de votre diagramme et vos scripts. Vous devrez alors être capable d'expliquer ce qui est écrit et justifier les raisons de vos choix.


# Éléments à respecter:
- les champs, les types de variables choisis et les contraintes doivent être cohérents.
- le nom des tables et des champs est uniforme (camelCase ou snake_case, minuscules partout) 
- les types de variables choisis sont cohérents et uniformes.
- les tables ont toutes des id artificiels auto-incrémentés.
