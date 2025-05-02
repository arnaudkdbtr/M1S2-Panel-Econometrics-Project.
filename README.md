![R Version](https://img.shields.io/badge/R-4.0%2B-blue)
![Panel Data](https://img.shields.io/badge/Analyse-Donn%C3%A9es%20Panel-brightgreen)
![Framework](https://img.shields.io/badge/M%C3%A9thode-Econom%C3%A9trie-orange)
![Documentation](https://img.shields.io/badge/Documentation-LaTeX-lightgrey)

# Analyse des déterminants des accidents mortels de la route aux États-Unis (1982-1988)

## 📌 Présentation du Projet

Ce projet vise à analyser les déterminants des accidents mortels de la route aux États-Unis en utilisant des données de panel couvrant la période 1982-1988. L’étude explore les facteurs socio-économiques, politiques et comportementaux influençant le taux de mortalité routière dans 48 États américains. L’objectif est d’apporter des éclairages pouvant guider les politiques publiques pour améliorer la sécurité routière.

## 📊 Jeu de Données

Les données utilisées proviennent du package AER sous R et sont issues de la base Fatalities, qui contient des données de panel annuelles sur les accidents mortels de la route aux États-Unis. Les principales sources sont :

- Bureau of Economic Analysis (BEA)
- National Highway Traffic Safety Administration (NHTSA)
- Bureau of Labor Statistics (BLS)

### Variables Clés :
- `fatalities` : Nombre de décès liés aux accidents de la route par État et par an.
- `income` : Revenu par habitant.
- `unemp` : Taux de chômage.
- `spirits` : Consommation d’alcool par habitant.
- `beertax` : Taxe sur la bière (proxy des politiques sur l’alcool).
- `miles` : Distance parcourue par habitant (transformée en logarithme).
- `gsp` : Croissance du produit intérieur brut de l’État (transformée en logarithme).

## 🏗 Méthodologie

Nous appliquons des techniques d’économétrie sur données de panel pour estimer l’impact des facteurs économiques et comportementaux sur la mortalité routière. Les modèles suivants sont comparés :

- Modèle Pooled OLS
- Modèle à Effets Fixes (FE)
- Modèle à Effets Aléatoires (RE)

### Spécification du Modèle :

log(fatal_it) = β₀ + β₁ income_it + β₂ unemp_it + β₃ spirits_it + β₄ beertax_it + β₅ log(miles_it) + β₆ log(gsp_it) + u_it

### Choix du Modèle :
- **Test de Fisher** confirme l’existence d’effets individuels significatifs → les modèles de panel sont préférés au modèle Pooled OLS.
- **Test de Hausman** rejette l’hypothèse d’exogénéité des effets individuels → le modèle à effets fixes est plus approprié.
- **Test de Wooldridge** détecte une autocorrélation dans les modèles Pooled OLS et à effets aléatoires → le modèle à effets fixes est privilégié.

## ⚙️ Implémentation

L’analyse est réalisée en **R**, en utilisant les packages suivants :
- `plm` (modélisation sur données de panel)
- `lmtest` (tests de diagnostic)
- `car` (tests statistiques)
- `stargazer` (tableaux de résultats formatés)

## 📂 Accédez aux fichiers

- [Dossier PDF final du projet](PDF_KINDBEITER_Arnaud_M1_DS2E.pdf)  
  Ce lien vous redirigera vers le document PDF détaillant les résultats finaux du projet. Le dossier final a été réalisé en utilisant **LaTeX**.
  
- [Code R utilisé dans l’analyse](R-CODE)  
  Vous pouvez explorer le code source du projet dans ce dossier pour plus de détails sur l'implémentation.

## Auteurs

- Arnaud KINDBEITER
