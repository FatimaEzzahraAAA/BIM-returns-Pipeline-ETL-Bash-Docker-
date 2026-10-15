# 🚀 BIM Returns Pipeline

> **Pipeline ETL automatisé** pour le traitement des retours clients BIM — Bash + Docker + Nginx + Dashboard web.

![Bash](https://img.shields.io/badge/Bash-5.x-4EAA25?logo=gnu-bash&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-24.x-2496ED?logo=docker&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-Alpine-009639?logo=nginx&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-blue)
![Status](https://img.shields.io/badge/Status-Production--ready-success)

---


## 🎯 Contexte

Exercice : **BIM** (Business Intelligence Maroc) exploite **3 succursales** :

| Succursale | Fichier quotidien |
|---|---|
| 🏢 Casablanca | `returns_casa.csv` |
| 🏢 Tanger | `returns_tanger.csv` |
| 🏢 Agadir | `returns_agadir.csv` |

Chaque jour, chaque succursale dépose un fichier CSV contenant les **retours clients** avec les colonnes :

##  🏗 Architecture

<img width="1408" height="768" alt="ETL simple" src="https://github.com/user-attachments/assets/838511f6-f9cc-4168-bdb9-385170e892b8" />


## 🎯 Objectifs
Le pipeline doit :

-    Récupérer les fichiers CSV des 3 succursales.
-    Valider la structure de chaque fichier (colonne reason présente).
-    Réparer automatiquement les fichiers dont la colonne a été renommée (ex : category, raison, motif).
-    Compter les retours par catégorie pour chaque succursale.
-    Générer un rapport consolidé output/report.csv (9 lignes = 3 villes × 3 raisons).
-    Archiver les fichiers traités avec la date du jour.
-    Logger toutes les opérations pour audit.
-    Exposer le rapport via un dashboard web interactif.

<img width="1408" height="768" alt="ETL expliqué" src="https://github.com/user-attachments/assets/c67e49db-2eb7-4e74-8eb8-4f068150f16b" />


##  🛠 Stack technique

-  Composant	Technologie	Rôle
-  Script ETL	Bash 5+	Traitement et orchestration
-  Parsing	awk, sed, grep	Validation, extraction, comptage
-  Containerisation	Docker (Alpine 3.20)	Isolation du runtime
-  Orchestration	Docker Compose	Lancement multi-services
-  Serveur web	Nginx (Alpine)	Exposition HTTP du rapport
-  Dashboard	HTML5 + CSS3 + Vanilla JS	Visualisation interactive

## 📁 Structure du projet

<img width="1408" height="768" alt="ETL detaillé" src="https://github.com/user-attachments/assets/d02f7ef5-58b3-4feb-9618-5e4ed481c8c5" />

## 📊 Dashboard web
Le dashboard viewer/index.html offre :

-    **KPI**: cards	Total, Defective, Wrong Item, Changed Mind
-    **Filtres	Par**: date, ville, raison
-    **Tableau triable**:	Clic sur l'en-tête pour trier
-    **Auto-refresh**:	Toutes les 10 secondes
-    **Reset**:	Bouton pour réinitialiser les filtres
-    **Responsive**:	Adapté mobile et desktop

<img width="1192" height="832" alt="Capture d&#39;écran 2026-10-15 205652" src="https://github.com/user-attachments/assets/0726770a-1ffe-45ee-8af4-1a1c2e08eb02" />


👤 Auteur:
Fatima-Ezzahra BOUMAIZE
🎓 Data Maroc Bootcamp — Promotion 2026
📧 fatimaezzahraboumaize020@gmail.com
