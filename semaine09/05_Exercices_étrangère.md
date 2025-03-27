# Exercices clé étrangère

a) À la suite d'un brainstorm, ont réfléchit à la création de tables. Pour chaque table et champs, créer le MRD. Ne pas oublier les multiplicités. Faire ensuite le script SQL en proposer des types de variables qui semblent adéquats. 

On veut une table d'étudiants avec :

- id_etudiant 
- nom 
- email 

On veut une table des cours avec :

- id_cours 
- nom_cours
- session
- groupe
- enseignant

On veut une table des inscriptions avec:

- date_inscription
- date_debut_cours

b) Insérer les clés primaires et les clés étrangères dans la table appropriée, avec les comportements par défaut. 

c) Insère des enregistrements dans clients et commandes (3 chaque).

d) Changer le comportement de la FK pour que les suppressions se fassent en CASCADE. Comment faire? Quel sera l'effet? Quel enregistrement supprimer pour voir l'effet?

e) Changer le comportement de la FK pour que les suppressions se fassent en SET NULL. Quel sera l'effet? Quel enregistrement supprimer pour voir l'effet?

