# Le génie logiciel

Définition:

- Le terme génie logiciel désigne l'ensemble des méthodes, des techniques et outils permettant la production d'un logiciel
- Au-delà de la seule activité de programmation
- L'appellation génie logiciel concerne l'ingénierie appliquée au logiciel informatique
- Cette branche de l'informatique s'intéresse plus particulièrement à la manière dont le code d'un logiciel est spécifié puis produit
- Le génie logiciel touche au cycle de vie des logiciels
- Toutes les phases de la création d'un logiciel informatique y sont abordées

Le choix du terme « génie » fait directement référence à celui du génie civil, désignant l'art de la construction

- En effet, pour construire un ouvrage architectural, le seul fait de poser brique et ciment ne suffit pas
- La construction d'un bâtiment est un tout, comprenant des activités de conception architecturale, de maçonnerie, de plomberie et d'électricité devant être coordonnées afin d'obtenir une maîtrise des délais et des budgets

## Histoire:
- Domaine de recherche qui a été défini du 7 au 11 octobre 1968, à Garmisch-Partenkirchen, sous le parrainage de l'OTAN
- Le génie logiciel a pour objectif de répondre à un problème qui s'énonçait en deux constatations : 
    - d'une part le logiciel n'était pas fiable,
    - d'autre part, il était incroyablement difficile de réaliser dans des délais prévus des logiciels satisfaisant leur **cahier des charges**.


## Culture générale:

- Dans les milieux anglophones hors Québec, on utilise le terme « software engineer » pour désigner une personne qui est analyste-système ou programmeur-analyste
- Au Québec, il est interdit de se désigner en tant qu’ingénieur logiciel, informatique ou système si on n’est pas membre de l’ordre des ingénieurs du Québec
    - Il s’agit d’un titre réservé
- Pour avoir le titre, il faudra avoir complété un bac en ingénierie ET être membre de l’ordre
    - Et d’autres détails qui sortent de l’objectif du cours


### Formation en génie logiciel:


À titre informatif, voici le cheminement requis pour étudier dans ce domaine, adapté pour ceux qui souhaitent se spécialiser dans le développement d'applications logicielles robustes et performante:
- Université Laval: https://www.ulaval.ca/etudes/programmes/baccalaureat-en-genie-logiciel
- Polytechnique: https://www.polymtl.ca/programmes/programmes/bc-logiciel
- ÉTS (école de technologie supérieure): https://www.etsmtl.ca/programmes-formations/baccalaureat-genie-logiciel 


## Facteurs de qualité et étapes de développement d’un logiciel

### Facteurs de qualité:

| **Facteur**              | **Description**                                                                                                                                       |
|--------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Validité**             | Aptitude d'un produit logiciel à remplir exactement ses fonctions, définies par le cahier des charges et les spécifications.                        |
| **Fiabilité ou robustesse** | Aptitude d'un produit logiciel à fonctionner dans des conditions anormales. <br> **Exemple** : La connexion internet n’est plus disponible ou encore l’utilisateur ouvre une image JPG dans bloc-notes. |
| **Extensibilité (maintenance)** | Facilité avec laquelle un logiciel se prête à sa maintenance, c'est-à-dire à une modification ou à une extension des fonctions qui lui sont demandées. |
| **Réutilisabilité**       | Aptitude d'un logiciel à être réutilisé, en tout ou en partie, dans de nouvelles applications.                                                       |
| **Compatibilité**         | Facilité avec laquelle un logiciel peut être combiné avec d'autres logiciels.                                                                        |
| **Efficacité**          | Utilisation optimale des ressources matérielles.                                                                                                     |
| **Portabilité**         | Facilité avec laquelle un logiciel peut être transféré sous différents environnements matériels et logiciels.                                         |
| **Vérifiabilité**       | Facilité de préparation des procédures de test.                                                                                                      |
| **Intégrité**           | Aptitude d'un logiciel à protéger son code et ses données contre des accès non autorisés.                                                            |
| **Facilité d’emploi**   | Facilité d'apprentissage, d'utilisation, de préparation des données, d'interprétation des erreurs et de rattrapage en cas d'erreur d'utilisation.    |

> Trouvons un exemple pour chacun!


## Cycle de développement d'un logiciel


- Le cycle de développement d’un logiciel est le processus de planification, création, tests et de déploiement d’un système d’information.
- Il y a plusieurs modèles de cycles de développement, mais ceux-ci ont généralement **6 phases** dans le cycle :

  1. **Analyse des requis** *(focus dans ce cours)*
  2. **Design** *(focus dans ce cours)*
  3. **Développement et tests** *(focus dans ce cours)*
  4. Implémentation
  5. Documentation
  6. Évaluation

> Nous nous concentrerons sur les trois premières phases (**Analyse des requis**, **Design**, **Développement et tests**) dans ce cours.

## Étapes du cycle de vie du développement

Définition des objectifs, consistant à définir la finalité du projet et son inscription dans une stratégie globale
1. Analyse des besoins et faisabilité
    - L'expression, le recueil et la formalisation des besoins du demandeur (le client)
2. Conception générale
    - L’élaboration des spécifications de l'architecture générale du logiciel
3. Conception détaillée
    - Définir précisément chaque sous-ensemble du logiciel

4. Codage 
    - La traduction dans un langage de programmation des fonctionnalités définies lors de phases de conception
5. Tests unitaires
    - permettant de vérifier individuellement que chaque sous-ensemble du logiciel est implémenté conformément aux spécifications
6. Intégration
    - S'assurer de l'interfaçage des différents éléments (modules) du logiciel. Elle fait l'objet de tests d'intégration consignés dans un document
7. Qualification
    - Vérification de la conformité du logiciel aux spécifications initiales

8. Documentation
    - Produire les informations nécessaires pour l'utilisation du logiciel et pour des développements ultérieurs.
9. Mise en production
    - Déploiement sur site du logiciel
10. Maintenance
    - Comprenant toutes les actions correctives (maintenance corrective) et évolutives (maintenance évolutive) sur le logiciel.
