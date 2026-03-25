if not exists (select * from sys.databases where name = 'exercices')
begin
    create database ma_bd;
end
use ma_bd;

-- création
drop table if exists ma_table;
create table ma_table (
    id int identity(1,1) primary key,
    nom varchar(255) not null,
    valeur decimal(10,2),
    actif bit default 1
);

-- FK
create table enfant (
    id int identity(1,1) primary key,
    id_parent int,

    foreign key (id_parent) references parent(id)
);

-- CREATE
insert into ma_table (nom)
values ('valeur');

insert into liaison (id_a, id_b)
select @id_a, id
from table_b as b
join table_c as c on c.id = b.id_table_c
where condition = 'x';

-- récupération id automatique (création du dernier id avec IDENTITY)
declare @id int;
set @id = scope_identity();

-- READ: select
select t1.nom, t2.nom
from table1 t1
join table2 t2 on t2.id_table1 = t1.id;

-- avec aggrégation
select 
    t.nom,
    t.valeur,
    string_agg(a.nom, ' + ') as liste
from table t
join autre a on a.id_table = t.id
group by t.nom, t.valeur;


-- UPDATE
update ma_table
set nom = 'nouvelle valeur'
where id = 1;

update table1
set id_parent = (select id from parent where condition = 'x')
where nom = 'exemple';

update t1
set t1.valeur = t2.valeur
from table1 t1
join table2 t2 on t1.id = t2.id;

-- DELETE
delete from ma_table
where id = @id;

-- ALETER TABLE
-- ajout colonne
-- Si on a un default dans la nouvelle colonne
declare @sql nvarchar(max);
select @sql = 'alter table ' + t.name + 
              ' drop constraint ' + d.name
from sys.columns c
join sys.tables t on c.object_id = t.object_id
join sys.default_constraints d on c.default_object_id = d.object_id
where t.name = 'ma_table'
and c.name = 'ma_colonne';

if (@sql is not null)
    exec sp_executesql @sql;
-- fin

alter table ma_table
drop column if exists nouvelle_colonne;

alter table ma_table
add nouvelle_colonne decimal(10,2) default 0;


-- DATE
select getdate();

select datediff(day, date_debut, date_fin);

update table1
set actif = 0
where getdate() between date_debut and date_fin;

-- Calculs
select 
    sum(valeur) * datediff(day, date_debut, date_fin) as total
from ma_table;


-- drop trigger
drop trigger if exists trg_historique_statuts;

-- Trigger après insertion (doit être le premier script du batch (après un GO))
create trigger trg_historique_statuts_insert
on tickets
after insert
as
begin
    insert into historique_statuts (id_ticket, id_statut_ancien)
    select
        i.numero,
        i.id_statuts
    from inserted i;
end;


-- Trigger après update
create trigger trg_historique_statuts
on tickets
after update
as
begin
    insert into historique_statuts (id_ticket, id_statut_ancien)
    select
        i.numero,
        d.id_statuts,
        i.id_statuts
    from inserted i
    join deleted d on i.numero = d.numero
    where i.id_statuts <> d.id_statuts;
end;

-- voir les triggers 
select name 
from sys.triggers;