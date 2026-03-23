## Exercice tickets

Le système en est un très simplifié qui simule les ticket (tâche à faire) par rapport à des projets, par des employés (utilisateurs). Quelques informations prises en note:
    - On attribue seulement le projet à un responsable

Avec le MRD NON-COMPLET suivant, faire les étapes suivantes:

1. compléter les colonnes manquantes pour conserver l'intégrité des données dans le MRD
2. faire le script de création des tables
3. créer un seed (serait fourni en évaluation)
4. créer la table historique_statut qui conserve l'évolution du statut des tickets dans le temps. Il faudra que cette table se remplisse automatiquement dès que le statuts du ticket change (trigger). En SQL server, on utilise la commande [AFTER UPDATE](https://learn.microsoft.com/en-us/sql/t-sql/functions/update-trigger-functions-transact-sql?view=sql-server-ver17)
   
5. faire les tests de CRUD pour constater ce qui fonctionne, vous imprégner du processus métier. Par exemple:
   - créer un projet
   - créer des tickets sur des projet (ou non?)
   - updater le statut du ticket
   - supprimer un utilisateur avec projet, et un sans projet, comment proposez-vous que ça se passe?
   - montrer les projets en cours
   - montrer l'évolution des statuts d'un ticket.