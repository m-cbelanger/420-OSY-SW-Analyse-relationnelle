# Exercices clés primaires


## Question 1

Voici des champs d’une table non normalisée (on verra la normalisation sous peu). La table parle d’achat de produits et devra éventuellement être normalisée. Pour l'instant, faisons comme s'il s'agissait d'une table telle quelle.
-	nom_client
-	prenom_client
-	numero_telephone
-	email
-	adresse 
-	numero_facture
-	code_barre_produit
-	mode_paiement
-	numero_carte_credit

a)	Quelles seraient les clés candidates pour être la clé primaire de cette table achat?

b)	Si on devait en choisir une, quelle serait la clé primaire naturelle choisie? Pourquoi? Quelle alternative proposez-vous?

c)  Quels champs devraient être UNIQUE?


## Question 2

Voici les champs d’une table qui n’est pas normalisée. La table servira à faire l’inventaire des animaux à la SPA du quartier
-	nom_animal
-	espece (chat, chien, furet, lapin, etc.)
-	race (bouvier, siamois, « race de lapin », etc.)
-	pellage_couleur
-	pellage_longueur
-	poids
-	temperament
-	vaccins_obtenus
-	age_adoption
-	numero_medaille

a)	Quelles seraient les clés candidates pour être la clé primaire de cette table animaux?
b)	Quelle seraient la clé primaire naturelle choisie? Pourquoi?
c)	Pourquoi l’age serait un mauvais choix dans une clé primaire composée?
d)	Pourquoi le poids serait un mauvais choix dans une clé primaire composée?


## Question 3

Faire une recherche et comparer les clés de type auto-incrément et les clés de type UUID. Nommez un avantage et un inconvénient à chaque.

