# Exercices examen 3

L'examen 3 aura 2 questions:
- 1 question où je propose une maquette entamée et un MRD complet et où je demande de compléter les champs ou les écrans manquants dans la maquette
- 1 question où je propose une maquette complète d'une application simple et où je demande de construire le MRD de la situation.

Matériel:
- Les notes de cours seront disponibles
- Une feuille de notes recto-verso est permise
- Aucun accès à internet
- Draw.io pour la création de maquette et de MRD obligatoire.

## Question 1

Voici un MRD et une maquette déjà entamée. Dans cet exercice, vous devez compléter la maquette selon les champs du MRD. 

Il faut que les interactions (donc tous les champs et boutons nécessaires) suivantes soient possibles:

- CRUD d'une pension (faire l'ajout d'une pension inexistante, voir les détails, les modifier, ajouter et enlever des animaux, etc.)
- voir les clients existants et leurs animaux
- ajouter, modifier et supprimer les animaux associés à un client

Ne pas considérer les éléments suivants:

- ajout / modifier / supprimer les **enclos** (kennels)
- ajout / modifier / supprimer les **employés**
- ajout / modifier / supprimer les **clients** 

## Question 2

Voici la maquette d'une application de gestion de ligue amicale de sport (ici le volleyball). On voit la maquette du point de vue de l'utilisateur non-admin. 

L'application permet de voir, dans l'écran d'accueil, le nom des équipes qui participent à la ligue ainsi que le nombre de sets gagnés et perdus au total dans la saison. L'équipe qui a le plus de sets gagnés est première, et on décline jusqu'à la dernière équipe. dans l'exemple, l'équipe 3 a gagné 60 sets et perdu 24 sets dans la saison. 60 est le nombre le plus élevé des nombres de sets gagnés, l'équipe 3 est donc à la position (pos) 1.

Quand on clique sur schedule, on voit une liste de jours de matchs. 

Construire le MRD qui permet de stocker tous les champs de cette maquette et conserver les relations. Le MRD doit contenir 
- les noms des tables, 
- le nom des champs, 
- les liaisons, 
- les FK, PK et 
- les multiplicités.
- La mention null ou not null est demandée MINIMALEMENT sur les FK. Non obligatoire sur le reste des champs.


# Examen final

L'examen final portera sur toute la matière depuis le début de la session. Les sujets POSSIBLES sont:

- normalisation
- intégrité référentielle
- création de MRD à partir d'une situation 
- création de MRD à partir d'une maquette
- ~~création d'une maquette à partir d'une situation~~
- ~~création d'une maquette à partir d'un MRD~~
- écriture de user stories
- analyse du UI/UX avec les règles établies de Mandel
- ~~script SQL~~

Voici quelques questions pour bonifier votre préparation. Il est recommandé de revoir les exercices des modules précédents également.

## Question 1

Par rapport à la question 1 de la section de préparation à l'examen 3:

a) quels sont 2 des rôles qui peuvent être occupés par les utilisateurs du logiciel de pension (SAUF ADMIN)
b) trouver 2 user stories, 1 par rôle


## Question 2

Visitez le site [IMDB](https://www.imdb.com/fr/).

a)	Identifier un élément qui est un BON choix de design en vous fiant aux règles d’or de Mandel. Des arguments subjectifs comme (« c’est moderne » ou « j’aime la taille des icônes ») ne seront pas retenus comme valides. Ce n’est pas une question de vos goûts, mais d’évaluer si le design est bon.

b)	Identifier un élément qui est un MAUVAIS choix de design et vous fiant sur des règles d’or de Mandel différentes de la question précédent. Des arguments subjectifs comme (« c’est laid » ou « je n’aime pas les couleurs ») ne seront pas retenus comme valides. Ce n’est pas une question de vos goûts, mais d’évaluer ce qui serait à améliorer dans le design.

## Question 3

Voici 2 interfaces avant-après.

![](img/interfaceA-B.png)

- identifier 5 problèmes dans l'interface A
- pour chaque problème, nommer la règle d'or de Mandel transgressée et expliquer brièvement pourquoi la règle n'est pas respectée
- expliquer comment le problème a été réglé dans l'interface B


## Question 4

Une clinique vétérinaire conserve actuellement ses informations dans un seule tableau:

| no_client | nom_client      | telephone    | no_animal | nom_animal | race            | no_veto | nom_veto   | date_rdv   |
| --------- | --------------- | ------------ | --------- | ---------- | --------------- | ------- | ---------- | ---------- |
| 1001      | Sophie Tremblay | 514-555-1023 | A001      | Minou      | Siamois         | V01     | Dre Gagnon | 2026-05-10 |
| 1001      | Sophie Tremblay | 514-555-1023 | A002      | Rex        | Berger allemand | V02     | Dr Leblanc | 2026-05-12 |
| 1002      | Marc Gauthier   | 438-555-8871 | A003      | Bella      | Labrador        | V01     | Dre Gagnon | 2026-05-11 |
| 1003      | Julie Caron     | 450-555-3344 | A004      | Kiwi       | Perroquet       | V03     | Dre Morin  | 2026-05-14 |
| 1002      | Marc Gauthier   | 438-555-8871 | A005      | Luna       | Chat domestique | V02     | Dr Leblanc | 2026-05-18 |
| 1004      | Éric Bouchard   | 819-555-2210 | A006      | Rocky      | Boxer           | V01     | Dre Gagnon | 2026-05-20 |
| 1001      | Sophie Tremblay | 514-555-1023 | A001      | Minou      | Siamois         | V03     | Dre Morin  | 2026-06-01 |
| 1005      | Caroline Nadeau | 581-555-7788 | A007      | Flash      | Husky           | V02     | Dr Leblanc | 2026-05-22 |

Proposer des tables pour stocker ces informations de manière à ce qu'elles respectent la 3NF (3e forme normale).
- Utiliser le fichier Excel clinique_vet pour conserver les données et faire des tables. 
- ajouter les FK et PK si nécessaire.
- dessiner ou expliquer les liaisons entre les tables (de quelle table/colonne vers quelle table/colonne)


# Question 5
Réponses courtes:

a) Qu’est-ce que l’intégrité référentielle dans une base de données relationnelle ?

b) Quel est le rôle d’une clé étrangère dans une table ?


c) Considérez les tables suivantes :

clients
| id_client | nom    |
| --------- | ------ |
| 1         | Sophie |
| 2         | Marc   |

commandes
| id_commande | id_client |
| ----------- | --------- |
| 101         | 1         |
| 102         | 5         |


Quelle ligne pose un problème d’intégrité référentielle ? Expliquez pourquoi.

d) L’intégrité référentielle sert principalement à :

    a) Accélérer les requêtes
    b) Empêcher les doublons
    c) Maintenir des relations valides entre les tables
    d) Trier les données automatiquement

e) Une clé étrangère :

    a) doit toujours être unique
    b) référence une clé primaire d’une autre table
    c) remplace la clé primaire
    d) ne peut pas contenir de nombres

f) Expliquer dans quel contexte il est acceptable de ne pas respecter totalement la normalisation en copiant des informations dans une autre table que celle dans laquelle elle est stockée

