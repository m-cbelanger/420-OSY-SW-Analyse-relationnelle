INSERT INTO utilisateurs (nom, prenom)
VALUES ('Robitaille', 'Marie-Ève'),
    ('Robin', 'Joanie'),
    ('Geoffroy', 'Emilie')
go

select * from utilisateurs
go

INSERT INTO projets (nom, date_creation, cloture, id_responsable)
VALUES ('Projet été', GETDATE(), 0, 1),
    ('Projet automne', GETDATE(), 1, 2),
    ('Projet hiver', GETDATE(), 0, 3)
go

select * from projets
go

INSERT INTO statuts (libelle)
VALUES ('Non démarré'),
	('En cours'),
    ('Terminé'),
    ('En attente'),
    ('Annulé')
go

select * from statuts
go

INSERT INTO tickets (titre, date_creation, description, id_auteur, id_projet, id_statut_actuel)
VALUES ('Ticket 1', GETDATE(), 'Description du ticket 1', 1, 1, 1),
    ('Ticket 2', GETDATE(), 'Description du ticket 2', 2, 2, 2),
    ('Ticket 3', GETDATE(), 'Description du ticket 3', 3, 3, 3)
go

select * from tickets
go

INSERT INTO commentaires (descriptions, id_utilisateur, id_ticket)
VALUES ('Commentaire sur le ticket 1', 1, 1),
    ('Commentaire sur le ticket 2', 2, 2),
    ('Commentaire sur le ticket 3', 3, 3)
go
select * from commentaires
go


INSERT INTO niveaux_bugs (ordre, libelle)
VALUES (1, 'Faible'),
    (2, 'Moyen'),
    (3, 'Élevé');
select * from niveaux_bugs
go

INSERT INTO versions (numero, id_projet)
VALUES ('1.0', 1),
    ('2.0', 2),
    ('3.0', 3)
go
select * from versions
go


INSERT INTO evolutions (priorite, id_ticket)
VALUES (1, 1),
    (2, 2),
    (3, 3)
go
select * from evolutions
go


INSERT INTO bugs (id_ticket)
VALUES (1),
    (2),
    (3)
go
select * from bugs
go



INSERT INTO bugs_versions (id_bug, id_version_associee)
VALUES (1, 1),
    (2, 2),
    (3, 3)
go
select * from bugs_versions
go


INSERT INTO tickets_associes (id_ticket_associe, id_ticket)
VALUES (1, 2),
    (2, 3),
    (3, 1)
go
select * from tickets_associes
go


/*
INSERT INTO historique (date, id_utilisateur, id_commentaire, id_ticket, id_statut)
VALUES (GETDATE(), 1, 1, 1, 1),
    (GETDATE(), 2, 2, 2, 2),
    (GETDATE(), 3, 3, 3, 3)
go
*/
select * from historique
go

UPDATE tickets
SET id_statut_actuel = 2
Where id = 1
go
select * from historique
go