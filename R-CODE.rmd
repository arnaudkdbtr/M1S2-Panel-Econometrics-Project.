rm(list = ls())

# Charger les bibliothèques nécessaires
library(AER)
library(plm)
library(lmtest)
library(car)
library(stargazer) #pour créer un tableau récapitulatif

# Charger la base de données Fatalities
data("Fatalities", package = "AER")

# Créer les données en panel
panel_data <- pdata.frame(Fatalities, index = c("state", "year"))

# Modèle OLS avec transformation logarithmique
pooled_model <- plm(log(fatal) ~ spirits + income + unemp + log(miles) + log(gsp) + beertax, data = panel_data, model = "pooling")
summary(pooled_model)
coeftest(pooled_model, vcov = vcovHC(pooled_model, type = "HC1"))

#Test d'autocorrélation de Wooldridge
autocorr_test <- pbgtest(pooled_model)
cat("\nTest d'autocorrélation de Wooldridge:\n")
print(autocorr_test)

bp_test <- bptest(pooled_model)
cat("\nTest de Breusch-Pagan (OLS):\n")
print(bp_test)

# Modèle à effets fixes (GLS "within")
fixed_model <- plm(log(fatal) ~ spirits + income + unemp + log(miles) + log(gsp) + beertax, data = panel_data, model = "within")
summary(fixed_model)

bp_test <- bptest(fixed_model)
cat("\nTest de Breusch-Pagan (OLS):\n")
print(bp_test)

#Test d'autocorrélation de Wooldridge
autocorr_test <- pbgtest(fixed_model)
cat("\nTest d'autocorrélation de Wooldridge:\n")
print(autocorr_test)

# Modèle à effets aléatoires (GLS "random")
random_model <- plm(log(fatal) ~ spirits + income + unemp + log(miles) + log(gsp) + beertax, data = panel_data, model = "random")
summary(random_model)

bp_test <- bptest(random_model)
cat("\nTest de Breusch-Pagan (OLS):\n")
print(bp_test)

#Test d'autocorrélation de Wooldridge
autocorr_test <- pbgtest(random_model)
cat("\nTest d'autocorrélation de Wooldridge:\n")
print(autocorr_test)

#Test de Fischer (test d'existence des effets individuels)
fisher_test <- pFtest(fixed_model, pooled_model)
cat("Test de Fischer:\n")
print(fisher_test)

#Test du multiplicateur de Lagrange (LM Test)
lagrange_test <- plmtest(pooled_model, effect = "individual", type = "bp")
cat("\nTest du multiplicateur de Lagrange (LM Test):\n")
print(lagrange_test)

#Test de Hausman (pour choisir entre effets fixes et aléatoires)
hausman_test <- phtest(fixed_model, random_model)
cat("\nTest de Hausman:\n")
print(hausman_test)

# Supprimer les lignes avec des valeurs manquantes dans les variables sélectionnées
panel_data_clean <- na.omit(panel_data[c("fatal", "spirits", "income", "unemp", "miles", "gsp", "beertax")])

# Calcul des statistiques descriptives manuellement
descriptive_stats <- data.frame(
  Variable = c("fatal", "spirits", "income", "unemp", "miles", "gsp", "beertax"),
  Mean = round(sapply(panel_data_clean[c("fatal", "spirits", "income", "unemp", "miles", "gsp", "beertax")], mean, na.rm = TRUE), 2),
  SD = round(sapply(panel_data_clean[c("fatal", "spirits", "income", "unemp", "miles", "gsp", "beertax")], sd, na.rm = TRUE), 2),
  Min = round(sapply(panel_data_clean[c("fatal", "spirits", "income", "unemp", "miles", "gsp", "beertax")], min, na.rm = TRUE), 2),
  Max = round(sapply(panel_data_clean[c("fatal", "spirits", "income", "unemp", "miles", "gsp", "beertax")], max, na.rm = TRUE), 2),
  Median = round(sapply(panel_data_clean[c("fatal", "spirits", "income", "unemp", "miles", "gsp", "beertax")], median, na.rm = TRUE), 2),
  Var = round(sapply(panel_data_clean[c("fatal", "spirits", "income", "unemp", "miles", "gsp", "beertax")], var, na.rm = TRUE), 2),
  N = sapply(panel_data_clean[c("fatal", "spirits", "income", "unemp", "miles", "gsp", "beertax")], function(x) sum(!is.na(x)))
)

descriptive_stats <- descriptive_stats[, -1]

# Afficher les statistiques descriptives ajustées
print(descriptive_stats)

# Tableau comparatif des différents modèles
stargazer(pooled_model, fixed_model, random_model, type = "text",
          title = "Comparaison des modèles : Pooled OLS, Fixed Effects, Random Effects",
          align = TRUE, no.space = TRUE, 
          column.labels = c("Pooled OLS", "Fixed Effects", "Random Effects"),
          covariate.labels = c("Spiritueux", "Revenu", "Chômage", "Miles (log)", "GSP (log)", "Taxe sur la bière"),
          dep.var.labels = "Log(Fatalités)",
          model.numbers = FALSE,
          omit.stat = c("f", "ser"), # Omitting F-stat and standard error
          star.cutoffs = c(0.1, 0.05, 0.01),
          notes = "HC1 robust standard errors for Pooled OLS.")

# Calculer la matrice de corrélation
cor_matrix <- cor(panel_data_clean)

# Enregistrer la matrice de corrélation en PDF
pdf("matrice_correlation.pdf")  # Ouvrir un périphérique graphique pour le PDF

# Afficher la matrice de corrélation avec des carreaux (square)
corrplot(cor_matrix, method = "square", type = "upper", tl.col = "black", tl.srt = 45, 
         title = "Matrice de Corrélation", mar = c(0,0,2,0))
dev.off()  # Fermer le périphérique graphique et enregistrer le fichier
