# Exercices intégrité référentielle

## Question 1

Voici 2 tables:


| clients |   |
| -- | ------ |
| id | nom    |
| 1  | Jean   |
| 2  | Sophie |
| 5  | Jonathan |
| 6  | Karim |


| commandes |               |||
| --- | ----------|--------- |---|
| id  | id_client | produit |quantite|
| 101 | 1         | Stylo   |   5|
| 102 | 2         | Cahier  |   3|
| 115 | 6         | Brocheuse |     3|

a) Que doit-on faire pour que ces tables respectent l'intégrité référentielle? Pour répondre à cette question, suivre la liste:
    - Laquelle est le parent, laquelle est l'enfant? 
    - Quels champs sont les PK, FK, UNIQUE? 
    - Quels comportement doit-on proposer lors de la suppression ou la mise à jour du parent? 
    - Quels types pour les colonnes? Des valeurs par défaut? 
    - Implémenter le tout dans un script SQL en insérant les valeurs présentes.


b) Si on essaie de faire les insertions suivantes, lesquelles vont fonctionner? Suivre la logique implantée en a).

```sql
INSERT INTO commandes (id, id_client, produit, quantite) 
VALUES (103, 3, 'Gomme',9),
(default, 2, 'Stylo',3),
(106, NULL, 'Feutre',7)
;

INSERT INTO clients (id, name) 
VALUES (DEFAULT, 'Sophie'),
(4, 'Abdel')
;
```
Est-ce que les insertions sont rejetées seulement quand c'est faux et on insère les bonnes? Comment ça se comporte?



c) Selon votre implémentation en a), il se passe quoi quand on roule le script suivant?

```sql
DELETE FROM clients WHERE id = 1;

DELETE FROM commandes WHERE id = 102; 

UPDATE clients SET id = 3 WHERE id = 6;
```


## Question 2
Expliquez pourquoi cette table est à risque d'engendrer des anomalies ou de ne pas respecter l'intégrité référentielle à un moment ou un autre

| id_client | nom_client  | email_client                                | id_commande | date_commande | id_produit | nom_produit | prix |
| --------- | ----------- | ------------------------------------------- | ----------- | ------------- | ---------- | ----------- | ---- |
| 1         | Jean Dupont | [jean@email.com](mailto:jean@email.com)     | 101         | 2025-03-01    | 501        | Stylo Bleu  | 1,50 |
| 1         | Jean Dupont | [jean@email.com](mailto:jean@email.com)     | 101         | 2025-03-01    | 502        | Cahier      | 3,00 |
| 2         | Sophie Roy  | [sophie@email.com](mailto:sophie@email.com) | 102         | 2025-03-02    | 503        | Gomme       | 0,75 |
| 2         | Sophie Roy  | [sophie@email.com](mailto:sophie@email.com) | 103         | 2025-03-03    | 501        | Stylo Bleu  | 1,50 |

