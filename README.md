
# 🛑 Save myself from failing the exam! 🚨

Bienvenue dans le projet **Show App** ! Ce projet consiste à développer une application mobile en Flutter qui interagit avec un backend Node.js. L'application permet aux utilisateurs de gérer une liste de films, séries et animés, avec des fonctionnalités CRUD (Create, Read, Update, Delete).

---

## 📝 Tâches à compléter

### 1️⃣ **Créer une Page de Mise à Jour (Update Show Page)**

- **Objectif** : Implémenter une page permettant de modifier un show existant.
- **Fonctionnalités** :
  - Pré-remplir les champs avec les informations du show sélectionné.
  - Permettre la mise à jour du titre, de la description, de la catégorie et de l’image.
  - Envoyer la mise à jour au backend via une requête `PUT`.

### 2️⃣ **Rendre la Page d'Accueil Dynamique (Auto-Refresh)**

- **Objectif** : Optimiser l'expérience utilisateur en rendant la page d'accueil dynamique.
- **Fonctionnalités** :
  - Mettre à jour la liste des shows automatiquement après un ajout ou une modification.
  - Éviter de devoir recharger manuellement l’application pour voir les nouvelles données.
  - Rafraîchir uniquement la partie concernée de l'interface utilisateur.

### 3️⃣ **Créer une Page de Connexion Fonctionnelle**

- **Objectif** : Implémenter une page de connexion pour authentifier les utilisateurs.
- **Fonctionnalités** :
  - Ajouter des champs pour l'email et le mot de passe.
  - Afficher un message d’erreur en cas de mauvais identifiants.
  - Stocker le token d’authentification après une connexion réussie pour les prochaines requêtes.

---

## 📂 Structure du Projet

Le projet est organisé comme suit :
show-app/
├── lib/

│ ├── main.dart

│ ├── screens/

│ │ ├── login_page.dart

│ │ ├── home_page.dart

│ │ ├── profile_page.dart

│ │ ├── add_show_page.dart

│ │ └── update_show_page.dart

│ ├── config/

│ │ └── api_config.dart

│ └── models/

│ └── show_model.dart

├── assets/


├── pubspec.yaml

└── README.md


---

## 🛠️ Configuration

### 1. **Backend**

- Le backend est développé en Node.js avec Express et SQLite.
- Les routes API sont disponibles pour gérer les opérations CRUD sur les shows.
- Les images sont stockées dans le dossier `uploads` du backend.

### 2. **Frontend (Flutter)**

- L'application Flutter utilise les packages suivants :
  - `http` : Pour les requêtes API.
  - `image_picker` : Pour sélectionner des images depuis la galerie ou l'appareil photo.
  - `provider` ou `riverpod` : Pour la gestion de l'état (optionnel).

### 3. **Variables d'environnement**

- L'URL de base de l'API est définie dans `lib/config/api_config.dart` :
  ```dart
  class ApiConfig {
    static const String baseUrl = "http://10.0.2.2:5000";
  }
