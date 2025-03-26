# Exercices clé étrangère

a) Crée une table clients avec :

- id_client (clé primaire, INT)

- nom (VARCHAR(100), non nul)

- email (VARCHAR(255), unique)

Crée une table commandes avec :

- id_commande (clé primaire, INT)

- date_commande (DATE, non nul)

b) Insérer une clé étrangère dans la table appropriée, avec les comportement par défaut. 

c) Insère des enregistrements dans clients et commandes (3 chaque).

d) Changer le comportement de la FK pour que les suppressions se fassent en CASCADE. Comment faire? Quel sera l'effet? Quel enregistrement supprimer pour voir l'effet?

e) Changer le comportement de la FK pour que les suppressions se fassent en SET NULL. Quel sera l'effet? Quel enregistrement supprimer pour voir l'effet?

