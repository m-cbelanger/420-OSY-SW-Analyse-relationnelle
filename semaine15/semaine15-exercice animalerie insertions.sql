use animalerie;

insert into clients (nom, num_tel,adresse, courriel)
values ('Mike','819-333-3333', '2 rue abc', 'mike@rona.com'),
('Joseph', '819-444-4444', '5444 gagnon', 'jo@gmail.com'),
('Marie-Christine', '819-442-4242', '54 bouvier', 'mary@gmail.com');

insert into employes (nom)
values ('caissier'),
('Marie'),
('Guylaine'), 
('Normand');

insert into animaux (id,id_client, nom, espece, race, couleur, qte_nourriture, nb_repas, prend_medic)
values ('C123',1,'minine','chat','bengal','marbré',156,3,0),
('C881',2,'pistache','chat','sphynx','peau',150,2,1),
('K981',1,'mousseline','chien','caniche','beige',100,2,1),
('K762',1,'gandalf','chien','grand danois','gris',500,2,0),
('K237',3,'colette','chien','teckel','brun',200,2,0);

insert into enclos (numero_alpha)
values ('A3'), 
('B12'), 
('C4');

insert into pensions (id_employe, date_arrivee, date_depart)
values (2,'2025-04-15 19:30:15', Null),
(2,'2025-04-20 19:30:15', '2025-04-22 10:40:15'),
(1,'2025-04-23 19:30:15', Null),
(4,'2025-04-28 14:30:05', '2025-04-29 10:40:15');

insert into enclos_pensions_animaux (id_animal, id_pension, id_enclos)
values ('K981',1,2),
('K762',1,2),
('C881',2,3),
('C881',3,3);

INSERT INTO soins (id_employe, date_traitement, type_soins, prix) VALUES
(1, '2025-05-01 09:00:00', 'Vaccination', 75.00),
(2, '2025-05-02 10:30:00', 'Vermifuge', 45.00),
(3, '2025-05-03 14:00:00', 'Détartrage', 120.00),
(1, '2025-05-04 16:15:00', 'Stérilisation', 200.00),
(2, '2025-05-05 11:45:00', 'Nettoyage des oreilles', 30.00),
(3, '2025-05-06 08:30:00', 'Consultation', 60.00);

INSERT INTO soins_animaux (id_soins, id_animaux) VALUES
(1, 'C123'),
(2, 'C881'),
(3, 'K237'),
(4, 'C123'),
(5, 'K237'),
(6, 'C881');



