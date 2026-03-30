if not exists (select * from sys.databases where name = 'exercice_tickets')
begin
    create database exercice_tickets;
end

use exercice_tickets;
go
drop table if exists tickets_projets;
drop table if exists historique_statuts;
drop table if exists tickets;
drop table if exists statuts;
drop table if exists projets;
drop table if exists utilisateurs;
go
create table utilisateurs(
    id int identity(1,1) primary key,
    nom varchar(255) not null
);

create table projets(
    id int identity(1,1) primary key,
    nom varchar(255) not null,
    date_creation date not null,
    est_termine bit default 0,

    id_utilisateur int,
    foreign key (id_utilisateur) references utilisateurs (id) on delete set null
);

create table statuts(
    id int identity(1,1) primary key,
    libelle varchar(255) not null
);

create table tickets(
    numero int identity(1,1) primary key,
    titre varchar(255),
    date datetime2 default getdate(),
    description varchar(1000),
    id_statut int not null default 1,

    foreign key (id_statut) references statuts (id)
);

create table tickets_projets (
    id_ticket int,
    id_projet int,
    primary key(id_ticket,id_projet),
    foreign key (id_ticket) references tickets(numero),
    foreign key (id_projet) references projets(id)

);

create table historique_statuts (
    id int identity(1,1) primary key,
    id_ticket int not null,
    id_statut_ancien int,
    date_changement datetime default getdate(),
    foreign key (id_ticket) references tickets (numero),
    foreign key (id_statut_ancien) references statuts (id),
);
go

create trigger trg_historique_statuts
on tickets
after update
as
begin
    insert into historique_statuts (id_ticket, id_statut_ancien)
    select
        i.numero,
        d.id_statut
    from inserted i
    join deleted d on i.numero = d.numero
    where i.id_statut <> d.id_statut;
end;

go

use exercice_tickets;
go

-- seed
insert into utilisateurs (nom) values
('marie tremblay'),
('jean dubois'),
('sophie gagnon'),
('alex martin');


insert into statuts (libelle) values
('ouvert'),
('en cours'),
('en attente'),
('résolu'),
('fermé');


insert into projets (nom, date_creation, est_termine, id_utilisateur) values
('site web boutique', '2026-01-10', 0, 1),
('application mobile', '2026-02-15', 0, 2),
('migration base de données', '2025-11-01', 1, 3);


insert into tickets (titre, description) values
('bug panier', 'le bouton ajouter au panier ne fonctionne pas'),
('crash login', 'l’application plante à la connexion'),
('optimisation requête', 'requête trop lente sur les rapports'),
('ui bouton', 'le bouton est mal aligné'),
('erreur paiement', 'transaction refusée sans raison');


insert into tickets_projets (id_ticket, id_projet) values
(1,1),
(2,2),
(3,3),
(4,1),
(5,1);

-- test trigger

update tickets set id_statut = 2 where numero = 1;
update tickets set id_statut = 3 where numero = 1;
update tickets set id_statut = 2 where numero = 1;
select * from historique_statuts;
go

-- tests CRUD

-- créer un projet
declare @id_utilisateur int = 3;
declare @nom_projet varchar(255) = 'renouvellement du parc informatique'

insert into projets (nom, date_creation,est_termine, id_utilisateur)
values (@nom_projet, getdate(), 0,@id_utilisateur);

go

-- créer un ticket
-- associé au projet 'application mobile'
declare @id_projet int = 2;
declare @titre_ticket varchar(255) = 'Analyse BD';
declare @description varchar(1000) = 'faire MRD et script'

insert into tickets (titre,description,id_statut)
values (@titre_ticket, @description,3)
;

declare @id_ticket int = scope_identity()
;
select @id_projet, @id_ticket;

insert into tickets_projets 
values (@id_ticket, @id_projet)
;

select * from tickets;
select * from tickets_projets;
go


-- update le statut du ticket créé
declare @id_stat int = 2;
declare @id_ticket int = 6;

select * from historique_statuts;

update tickets
set id_statut = @id_stat
where numero = @id_ticket;

select * from historique_statuts;

-- supprimer utilisateur sans projet:
/*
declare @id_user int = (select top 1 u.id
                        from utilisateurs as u
                        left join projets as p on p.id_utilisateur = u.id
                        where p.id_utilisateur is null)
;
delete from utilisateurs
where id = @id_user;

-- avec projet

set @id_user = (select top 1 u.id
                from utilisateurs as u
                join projets as p on p.id_utilisateur = u.id
                where p.id_utilisateur is not null)


delete from utilisateurs
where id = @id_user;
select * from projets;
select * from utilisateurs;
*/
-- Si on veut empêcher la suppression d'utilisateurs qui ont des projet attitrés, on laisse ça comme ça
-- Sinon, on peut aussi faire un set null dans la table projets, pour le delete. 
-- La cascade est peu recommandée ici


-- Montrer les projets en cours
select 
    p.nom
from projets as p
join tickets_projets as tp on tp.id_projet = p.id
join tickets as t on t.numero = tp.id_ticket
join statuts as s on s.id = t.id_statut
where t.id_statut =  (select id from statuts where libelle = 'en cours');
go


-- montrer l'évolution d'un ticket
-- peupler un peu la table d'abord
declare @id_ticket int = 6;

update tickets
set id_statut = 3
where numero = @id_ticket;
update tickets
set id_statut = 4
where numero = @id_ticket;


-- montrer quelques info
select t.titre,
    hs.id_statut_ancien,
    hs.date_changement

from historique_statuts as hs
join tickets as t on t.numero = hs.id_ticket
where hs.id_ticket = @id_ticket

select * from tickets;