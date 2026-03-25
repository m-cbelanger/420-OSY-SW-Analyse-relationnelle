# Solutions questions boardings

## Question 1 a) et b)
```sql
if not exists (select * from sys.databases where name = 'exercices')
begin
    create database exercices;
end

use exercices;
go

-- drop
drop table if exists boardings_animals;
drop table if exists invoices;
drop table if exists boardings;
drop table if exists animals;
drop table if exists kennels;
drop table if exists employees;
drop table if exists clients;
go


-- tables
if not exists (select * from sys.tables where name = n'clients')
begin
    create table clients (
        id int identity(1,1) primary key,
        name varchar(255) not null,
        phone varchar(20) not null,
        email varchar(255)
    );
end

if not exists (select * from sys.tables where name = n'employees')
begin
    create table employees (
        id int identity(1,1) primary key,
        name varchar(255) not null,
        phone varchar(20) not null,
        email varchar(255) not null,
        hired_date date not null,
        termination_date date
    );
end

if not exists (select * from sys.tables where name = n'kennels')
begin
    create table kennels (
        code varchar(20) primary key,
        capacity tinyint check (capacity <= 4),
        detail varchar(1000),
        is_available bit default 1
    );
end

if not exists (select * from sys.tables where name = n'animals')
begin
    create table animals (
        id int identity(1,1) primary key,
        name varchar(255) not null,
        specie varchar(255),
        breed varchar(255),
        color varchar(255),
        food_quantity decimal(10,2),
        meals_per_day tinyint,
        takes_med bit default 0,
        comment varchar(1000),
        id_client int not null,

        foreign key (id_client) references clients(id)
    );
end

if not exists (select * from sys.tables where name = n'boardings')
begin
    create table boardings (
        id int identity(1,1) primary key,
        arrival_date date not null,
        departure_date date not null,
        id_employee int,
        code_kennel varchar(20),

        foreign key (id_employee) references employees(id) on delete set null,
        foreign key (code_kennel) references kennels(code) on delete set null
    );
end

if not exists (select * from sys.tables where name = n'boardings_animals')
begin
    create table boardings_animals (
        id_boarding int not null,
        id_animal int not null,

        primary key(id_boarding, id_animal),
        foreign key (id_boarding) references boardings(id) on delete cascade,
        foreign key (id_animal) references animals(id) on delete cascade
    );
end


-- seed
-- ======================
-- clients
-- ======================
insert into clients (name, phone, email) values
('Jean Tremblay', '514-555-1234', 'jean.tremblay@email.com'),
('Marie Gagnon', '438-555-5678', 'marie.gagnon@email.com'),
('Luc Bouchard', '514-555-8899', 'luc.bouchard@email.com'),
('Sophie Roy', '450-555-2222', 'sophie.roy@email.com'),
('David Pelletier', '514-555-7777', 'david.pelletier@email.com'),
('Caroline Lavoie', '438-555-1111', null);

-- ======================
-- employees
-- ======================
insert into employees (name, phone, email, hired_date, termination_date) values
('Karine Dubois', '514-555-1112', 'karine.dubois@pension.com', '2022-03-10', null),
('Marc Lavoie', '514-555-2223', 'marc.lavoie@pension.com', '2021-07-15', null),
('Julie Morin', '438-555-3333', 'julie.morin@pension.com', '2023-01-20', null),
('Patrick Gauthier', '450-555-4444', 'patrick.gauthier@pension.com', '2026-03-01', null);

-- ======================
-- kennels
-- ======================
insert into kennels (code, capacity, detail, is_available) values
('ABC', 2, 'avec étages', 1),
('DEF', 4, 'avec faux gazon', 1),
('GHI', 1, 'modules inclus', 1),
('JKL', 2, 'avec jouet et faux gazon', 1),
('MNO', 3, 'près de aire commune', 1),
('PQR', 1, 'près de aire commune', 1),
('STU', 2, 'faux gazon', 1),
('VWX', 1, 'isolement', 1),
('ZZZ', 2, 'réserve', 1);

-- ======================
-- animals
-- ======================
insert into animals (name, specie, breed, color, food_quantity, meals_per_day, takes_med, comment, id_client) values
('Rex', 'chien', 'Berger Allemand', 'brun et noir', 2.50, 2, 0, 'Très énergique', 1),
('Charlie', 'chien', 'Golden Retriever', 'doré', 2.80, 2, 0, 'Très amical', 1),
('Mimi', 'chat', 'Siamois', 'crème', 0.30, 2, 0, 'Aime dormir au soleil', 2),
('Minou', 'chat', 'Domestique', 'gris', 0.25, 2, 0, 'Très calme', 3),
('Bella', 'chien', 'Caniche', 'blanc', 1.20, 2, 1, 'Médicament pour allergies', 4),
('Coco', 'petit_animal', 'lapin nain', 'blanc', 0.15, 2, 0, null, 5),
('Pitou', 'chien', 'Labrador', 'noir', 3.00, 2, 0, 'Adore jouer à la balle', 6),
('Bella', 'chien', 'Teckel', 'brun', 1.20, 2, 1, 'Agressif avec les autres chiens', 6);

-- ======================
-- boardings
-- ======================
insert into boardings (arrival_date, departure_date, id_employee, code_kennel) values
('2026-03-01', '2026-03-05', 1, 'ABC'),
('2026-03-06', '2026-03-10', 3, 'JKL'),
('2026-03-10', '2026-03-14', 3, 'DEF'),
('2026-03-14', '2026-03-18', 2, 'STU'),
('2026-03-15', '2026-03-19', 2, 'GHI'),
('2026-03-16', '2026-03-20', 3, 'ABC'),
('2026-03-18', '2026-03-22', 1, 'DEF'),
('2026-03-22', '2026-03-26', 2, 'GHI'),
('2026-03-26', '2026-03-30', 2, 'MNO'),
('2026-04-01', '2026-04-05', 3, 'PQR'),
('2026-04-05', '2026-04-09', 1, 'STU'),
('2026-04-10', '2026-04-14', 2, 'ABC'),
('2026-04-20', '2026-04-24', 3, 'DEF'),
('2026-04-20', '2026-04-24', 1, 'GHI');

-- ======================
-- boardings_animals
-- ======================
insert into boardings_animals (id_boarding, id_animal) values
(1,1),(1,2),(2,3),(2,4),(3,5),(3,7),(4,6),(5,7),(5,8),
(6,1),(6,2),(7,5),(7,8),(8,7),(9,4),(10,3),(11,6),(12,1),(13,5),(14,7);

go

select * from boardings_animals;

```

## Question 1c)
```sql
-- création dans clients
declare @nom varchar(255) = 'Kevin Fournier'
declare @numero varchar(20) = '819-111-5555'

insert into clients (name, phone, email)
values(@nom,@numero, null)
GO

-- création boarding
declare @arrival_date date = '2026-05-01'
declare @departure_date date = '2026-05-05'
declare @nom_employe varchar(255) = 'Marc Lavoie'
declare @code_kennel varchar(20) = 'ABC'
declare @client varchar(255) = 'Jean Tremblay'

insert into boardings (arrival_date, departure_date, id_employee, code_kennel)
values (@arrival_date,
        @departure_date,
        (select id from employees where name = @nom_employe),
        @code_kennel
        );


-- ajout des boardings_animals pour compléter
declare @id_boarding int;
set @id_boarding = scope_identity();

insert into boardings_animals (id_boarding,id_animal)
select 
    @id_boarding, 
    id
from animals 
where id in (select a.id
            from animals as a
            join clients as c on a.id_client = c.id
            where c.name = @client
            )

select * from boardings_animals;
```

## Question 1d)
```sql
-- Read
-- d) montrer une réservation
set @id_boarding = 15;
select 
    c.name as 'client',
    STRING_AGG(a.name, ' + ') as 'animaux',
    b.arrival_date as 'date arrivée',
    b.departure_date as 'date départ',
    b.code_kennel as 'enclos'
from clients as c
join animals as a on a.id_client = c.id
join boardings_animals as b_a on b_a.id_animal = a.id
join boardings as b on b.id = b_a.id_boarding
where b.id = @id_boarding
group by c.name,b.arrival_date,b.code_kennel, b.departure_date
;
go
```

## Question 1e)
```sql
-- e) update
declare @phone1 varchar(20) = '450-555-2222';
declare @phone2 varchar(20) = '514-555-1234';
declare @nom_animal varchar(255) = 'Bella';
declare @id_client2 int = (select id 
                            from clients 
                            where phone = @phone2)

select * from animals where name = @nom_animal;

update animals
set id_client = @id_client2
where name = @nom_animal and id_client = (select id 
                                        from clients 
                                        where phone = @phone1)
;
select * from animals where name = @nom_animal;
go


-- ajouter le nouveau chien à la réservation
declare @id_reservation int = 15
declare @phone varchar(20) = '514-555-1234'
declare @nom_animal varchar(255) = 'Bella'

select * from boardings_animals;
insert into boardings_animals
select 
    @id_reservation,
    (select 
        id 
     from animals 
     where name = @nom_animal and id_client = (select id from clients where phone = @phone)
     )

select * from boardings_animals;
```

## Question 1f)
```sql
-- f) supprimer un animal de la réservation
declare @animal_retire varchar(255) = 'Charlie';
declare @phone_retire varchar(20) = '514-555-1234'
declare @date_retire date = '2026-05-01';

declare @id_boarding int;
declare @id_animal int;

-- pour trouver les id_boarding et id_animal associés (auraient pu être directement dans les variables)
set @id_boarding = (
    select b.id
    from boardings as b
    join boardings_animals as b_a on b.id = b_a.id_boarding
    join animals as a on b_a.id_animal = a.id
    join clients as c on c.id = a.id_client
    where c.phone = @phone_retire 
    and a.name = @animal_retire 
    and b.arrival_date = @date_retire
);

set @id_animal = (
    select a.id 
    from animals as a
    join clients as c on c.id = a.id_client
    where a.name = @animal_retire 
    and c.phone = @phone_retire
);

-- vérification avant
select * 
from boardings_animals 
where id_boarding = @id_boarding and id_animal = @id_animal;

-- suppression
delete 
from boardings_animals
where id_boarding = @id_boarding and id_animal = @id_animal;

-- vérification après
select * 
from boardings_animals 
where id_boarding = @id_boarding;
go
```


## Question 2

Il s'agit de faire un update sur la colonne de is_available par rapport à la date du jour.
```sql
-- Question2

select * from kennels;

-- mettre les enclos qui étaient occupés, mais qui ne le sont plus à 1
update kennels
set is_available = 1
where code not in (
    select code_kennel 
    from boardings
    where arrival_date <= getdate() 
    or departure_date >= getdate()
    and code_kennel is not null
);


-- mettre les enclos qui étaient non-occupés, mais qui le sont aujourd'hui à 0.
update k
set k.is_available = 0
from kennels as k
join boardings as b on b.code_kennel = k.code
where GETDATE() between b.arrival_date and b.departure_date
;
select GETDATE() AS DATE;
select departure_date 
from boardings;


select * from kennels;

go
```


## Question 3

```sql
-- Question 3
use exercices;
GO


-- si on met une contrainte default (un objet de BD), il faut drop la contrainte avant de la recréer
-- puisqu'elle se crée toute seule, le nom change à toutes les fois. Exemple:DF__kennels__price_p__3AE1A5DA
declare @tableName as varchar(128) = 'kennels';
declare @columnName as varchar(128) = 'price_per_day';
declare @sql nvarchar(MAX);

select @sql = 'alter table ' + quotename(T.name) + ' drop constraint ' + quotename(D.name) + ';'
from sys.columns as C
inner join sys.tables T on C.object_id = T.object_id
inner join sys.default_constraints as D on C.default_object_id = D.object_id -- trouver le nom de la contrainte
where T.name = @tableName and C.name = @columnName;

-- imprimer en console le script qu'on souhaite exécuter
print @sql;

-- executer la ligne de code
if (@sql is not null)
    exec sp_executesql @sql;
-- fin du drop de la contrainte default

alter table kennels
drop column if exists price_per_day;

alter table kennels
add price_per_day decimal(10,2) not null default 0;
GO

declare @prix_tous decimal(10,2)= 15
declare @prix_specifique decimal(10,2)= 25

update kennels
set price_per_day = @prix_tous;

update kennels
set price_per_day = @prix_specifique
where code in ('ABC','DEF','GHI');
GO

select * from kennels


-- drop contrainte default
declare @tableName as varchar(128) = 'boardings_animals';
declare @columnName as varchar(128) = 'paid_price_per_day';
declare @sql nvarchar(MAX);

select @sql = 'alter table ' + quotename(T.name) + ' drop constraint ' + quotename(D.name) + ';'
from sys.columns as C
inner join sys.tables T on C.object_id = T.object_id
inner join sys.default_constraints as D on C.default_object_id = D.object_id -- trouver le nom de la contrainte
where T.name = @tableName and C.name = @columnName;

print @sql;

if (@sql is not null)
    exec sp_executesql @sql;
-- fin du drop de la contrainte default


alter table boardings_animals
drop column if exists paid_price_per_day;

alter table boardings_animals
add paid_price_per_day decimal(10,2) null
GO

select * from boardings_animals;

-- copier des boarding_animals
update boardings_animals
set paid_price_per_day = k.price_per_day 
from kennels as k
join boardings b on k.code = b.code_kennel
join boardings_animals as ba on ba.id_boarding = b.id

-- résultat   
select b.code_kennel,
       k.code,
       ba.paid_price_per_day,
       k.price_per_day
from boardings as b
join kennels as k on b.code_kennel = k.code
join boardings_animals as ba on ba.id_boarding = b.id

```

## Question 4

```sql
-- Question 4

use exercices;
go

drop table if exists invoices ;

create table invoices (
    id int identity(1,1) primary key,
    id_boarding int not null,
    invoice_date date,
    total_bt decimal(10,2),
    taxe_rate decimal(5,4),
    status varchar(10),

    foreign key (id_boarding) references boardings(id)
);
go

declare @statut varchar(10) = 'n/a'

-- create
insert into invoices (id_boarding, invoice_date, total_bt, taxe_rate, status)
select 
    b.id,
    getdate(),
    sum(ba.paid_price_per_day) * datediff(day, b.arrival_date, b.departure_date),
    0.15, -- pourrait provenir d'une table de taxe_rate
    @statut
from boardings b
join boardings_animals ba on ba.id_boarding = b.id
where b.departure_date < getdate()
group by b.id, b.arrival_date, b.departure_date;

select * from boardings;
select * from invoices;

-- montrer (read) une facture GLOBALE (pas de nom de client)
select
    inv.id,
    b.id,
    inv.invoice_date,
    inv.total_bt,
    inv.total_bt * (1 + inv.taxe_rate) as total_at,
    datediff(day, b.arrival_date, b.departure_date) as nombre_jours,
    string_agg(a.name, ' - ') as animaux
from invoices as inv
join boardings as b on b.id = inv.id_boarding
join boardings_animals as ba on ba.id_boarding = b.id
join animals as a on a.id = ba.id_animal
group by inv.id, b.id, inv.invoice_date, inv.total_bt, inv.taxe_rate, b.arrival_date, b.departure_date;

-- montant (read) facture PAR client
select
    inv.id,
    b.id,
    c.name,
    inv.invoice_date,
    sum(ba.paid_price_per_day) * datediff(day, b.arrival_date, b.departure_date) as total_bt,
    sum(ba.paid_price_per_day) * datediff(day, b.arrival_date, b.departure_date) * (1+taxe_rate) as total_at,
    datediff(day, b.arrival_date, b.departure_date) as nombre_jours,
    string_agg(a.name, ' - ') as animaux
from invoices as inv
join boardings as b on b.id = inv.id_boarding
join boardings_animals as ba on ba.id_boarding = b.id
join animals as a on a.id = ba.id_animal
join clients as c on c.id = a.id_client
group by inv.id, 
        b.id, 
        c.name, 
        inv.invoice_date, 
        inv.taxe_rate, 
        b.arrival_date, 
        b.departure_date;

-- delete et update laissés à votre discrétion
```
