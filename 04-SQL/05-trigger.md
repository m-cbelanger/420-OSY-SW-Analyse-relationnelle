
## L'objet trigger

Un trigger est une commande qui est déclenchée en réaction à une autre action en BD

| Raisons d’utiliser un TRIGGER     | Explication |
|----------------------------------|-------------|
| **Centralisation de la logique** | La logique métier est exécutée dans la BD, ce qui assure qu'elle est toujours appliquée peu importe l'application ou le langage qui accède à la BD. |
| **Automatisation**               | Permet de déclencher automatiquement une action (ex. : mise à jour d’un historique, validation, synchronisation) sans coder cette action à chaque fois. |
| **Sécurité**                     | Évite que la logique soit contournée par une erreur ou un oubli dans l'application. |
| **Maintenance**                  | Moins de duplication de code, plus facile à modifier dans un seul endroit. |


[Trigger en SQL server](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-trigger-transact-sql?view=sql-server-ver16)


Par exemple, si on veut créer un trigger pour créer une facture dès l'insertion d'une commande au resto. La facture ci-dessous a des éléments retirés pour garder une simplicité d'explication:

```sql
-- ne pas oublier le drop préalable pour rouler le script plusieurs fois
create table commandes (
    id int identity(1,1) primary key,
    numero_table INT NOT NULL,
    numero_client INT NOT NULL,
    date_commande DATETIME NOT NULL DEFAULT GETDATE()
);


create table factures (
    id int identity(1,1) primary key,
    id_commande int not null,
    date_facture datetime not null default GETDATE(),
    total decimal(10,2) default 0,
    foreign key (id_commande) references commandes(id)
);
```

Trigger qui insert une ligne facture en réaction à la ligne commande qui est créée

```sql
create trigger trg_commande_insert
on commandes
after insert
as
begin
    set nocount on;
    insert into factures (id, date_facture, total)
    select id, getdate(), 0
    from inserted;
end;
```

note: le trigger doit être la première commande de son lot, alors il doit être précédé d'un GO, s'il ne s'agit pas de la première commande du script.

### Script complet pour que ça marche:
```sql
use historisation;
go

drop trigger if exists trg_commande_insert; 
drop table if exists factures;
drop table if exists commandes;
go

create table commandes (
    id int identity(1,1) primary key,
    numero_table INT NOT NULL,
    numero_client INT NOT NULL,
    date_commande DATETIME NOT NULL DEFAULT GETDATE()
);

create table factures (
    id int identity(1,1) primary key,
    id_commande int not null,
    date_facture datetime not null default GETDATE(),
    total decimal(10,2) default 0,
    foreign key (id_commande) references commandes(id)
);
go

create trigger trg_commande_insert
on commandes
after insert
as
begin
    insert into factures (id_commande, date_facture, total)
    select id, getdate(), 0
    from inserted;
end;
go
```

Maintenant faire une insertion dans la table appropriée et observez si la réaction fonctionne dans l'autre table.

```sql
-- à vous de jouer! 
```



