# 🎯 CV Analyzer - Guide d'Installation Complet

Application d'analyse de CV avec Intelligence Artificielle et chatbot intelligent utilisant l'API Groq.

---

## 📋 Table des matières

- [Prérequis](#-prérequis)
- [Installation depuis GitHub](#-installation-depuis-github)
- [Configuration de la base de données](#-configuration-de-la-base-de-données)
- [Configuration du Backend](#️-configuration-du-backend)
- [Configuration du Frontend](#-configuration-du-frontend)
- [Lancement du projet](#-lancement-du-projet)
- [Accès à l'application](#-accès-à-lapplication)
- [Dépannage](#-dépannage)

---

## 🔧 Prérequis

Avant de commencer, installez ces logiciels :

### 1. XAMPP (Recommandé) ou WAMP

**Téléchargement XAMPP :**
- Windows : https://www.apachefriends.org/download.html
- Téléchargez la version avec PHP 8.0 ou supérieur

**Installation :**
1. Exécutez l'installateur
2. Installez dans `C:\xampp` (chemin par défaut)
3. Cochez : Apache, MySQL, PHP, phpMyAdmin

**Démarrage :**
1. Ouvrez XAMPP Control Panel
2. Cliquez sur "Start" pour Apache
3. Cliquez sur "Start" pour MySQL

### 2. Node.js et NPM

**Téléchargement :**
- https://nodejs.org/ (Téléchargez la version LTS)

**Vérification :**
```bash
node -v
npm -v
```

### 3. Git

**Téléchargement :**
- https://git-scm.com/downloads

**Vérification :**
```bash
git --version
```

---

## 📥 Installation depuis GitHub

### Étape 1 : Cloner le projet

Ouvrez votre terminal (CMD, PowerShell, ou Terminal) :
```bash
# Naviguez vers votre dossier de travail (exemple : Bureau)
cd Desktop

# Clonez le projet
git clone https://github.com/SersifAbdeljalil/CV_analyse.git

# Entrez dans le dossier
cd CV_analyse
```

---

## 💾 Configuration de la base de données

### Étape 1 : Démarrer XAMPP

1. Ouvrez **XAMPP Control Panel**
2. Démarrez **Apache** et **MySQL**

### Étape 2 : Créer la base de données

**Option 1 : Avec phpMyAdmin (Recommandé)**

1. Ouvrez votre navigateur
2. Allez sur : http://localhost/phpmyadmin
3. Cliquez sur "Nouvelle base de données"
4. Nom : `cv_analyzer`
5. Interclassement : `utf8mb4_unicode_ci`
6. Cliquez sur "Créer"

### Étape 3 : Importer la base de données

1. Dans phpMyAdmin, sélectionnez la base `cv_analyzer`
2. Cliquez sur l'onglet "Importer"
3. Cliquez sur "Choisir un fichier"
4. Sélectionnez le fichier `cv_analyzer.sql` (fourni dans le projet)
5. Cliquez sur "Exécuter" en bas de la page
6. Attendez la confirmation "Importation réussie"

**Option 2 : Avec MySQL en ligne de commande**
```bash
# Se connecter à MySQL
mysql -u root -p

# Créer la base de données
CREATE DATABASE cv_analyzer CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# Quitter MySQL
EXIT;

# Importer le fichier SQL
mysql -u root -p cv_analyzer < cv_analyzer.sql
```

---

## ⚙️ Configuration du Backend

### Étape 1 : Accéder au dossier backend
```bash
cd backend
```

### Étape 2 : Installer les dépendances PHP
```bash
composer install
```

⏱️ **Cette étape peut prendre 2-5 minutes**

### Étape 3 : Créer le fichier .env

**Option 1 : Copier le fichier (Windows)**
```cmd
copy .env.example .env
```

**Option 2 : Copier le fichier (Mac/Linux)**
```bash
cp .env.example .env
```

### Étape 4 : Modifier le fichier .env

Ouvrez le fichier `backend/.env` avec un éditeur de texte et **remplacez tout le contenu** par :
```env
APP_NAME=CVAnalyzer
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost:8000

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=cv_analyzer
DB_USERNAME=root
DB_PASSWORD=

# CORS Configuration
CORS_ALLOWED_ORIGINS=http://localhost:3000,http://127.0.0.1:3000

# Sanctum Configuration
SANCTUM_STATEFUL_DOMAINS=localhost:3000,127.0.0.1:3000
SESSION_DOMAIN=
SESSION_DRIVER=cookie

# Groq Configuration (GRATUIT)
GROQ_API_KEY=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
GROQ_MODEL=llama-3.3-70b-versatile
GROQ_API_URL=https://api.groq.com/openai/v1/chat/completions

# Storage
FILESYSTEM_DISK=public
```

### Étape 5 : Générer la clé d'application
```bash
php artisan key:generate
```

### Étape 6 : Créer le lien symbolique pour le storage
```bash
php artisan storage:link
```

### Étape 7 : Vider les caches
```bash
php artisan config:clear
php artisan cache:clear
php artisan config:cache
```

✅ **Backend configuré !**

---

## 🎨 Configuration du Frontend

### Étape 1 : Revenir à la racine et accéder au frontend
```bash
# Depuis le dossier backend, remontez d'un niveau
cd ..

# Accédez au dossier frontend
cd frontend
```

### Étape 2 : Installer les dépendances Node.js
```bash
npm install
```

⏱️ **Cette étape peut prendre 3-7 minutes**

### Étape 3 : Créer le fichier .env

Créez un fichier `.env` dans le dossier `frontend` avec ce contenu :
```env
REACT_APP_API_URL=http://localhost:8000
```

**Création du fichier :**

**Windows (CMD) :**
```cmd
echo REACT_APP_API_URL=http://localhost:8000 > .env
```

**Mac/Linux :**
```bash
echo "REACT_APP_API_URL=http://localhost:8000" > .env
```

✅ **Frontend configuré !**

---

## 🚀 Lancement du projet

Vous avez besoin de **2 terminaux** (ou 2 onglets).

### Terminal 1 : Backend Laravel
```bash
# Depuis la racine du projet
cd backend

# Lancer le serveur Laravel
php artisan serve
```

**Vous devriez voir :**
```
INFO  Server running on [http://127.0.0.1:8000]
```

**⚠️ NE FERMEZ PAS CE TERMINAL !**

---

### Terminal 2 : Frontend React

**Ouvrez un NOUVEAU terminal**, puis :
```bash
# Depuis la racine du projet
cd frontend

# Lancer le serveur React
npm start
```

**Vous devriez voir :**
```
Compiled successfully!

You can now view frontend in the browser.

  Local:            http://localhost:3000
```

Votre navigateur devrait s'ouvrir automatiquement sur http://localhost:3000

**⚠️ NE FERMEZ PAS CE TERMINAL !**

---

## 🌐 Accès à l'application

Une fois les deux serveurs lancés :

| Service | URL |
|---------|-----|
| **Interface utilisateur** | http://localhost:3000 |
| **API Backend** | http://localhost:8000 |
| **phpMyAdmin** | http://localhost/phpmyadmin |

---

## ✅ Test de l'application

### 1. Créer un compte

1. Allez sur http://localhost:3000
2. Cliquez sur "S'inscrire"
3. Remplissez le formulaire :
   - Nom : Votre nom
   - Email : votre@email.com
   - Mot de passe : minimum 8 caractères
   - Confirmation : même mot de passe
4. Cliquez sur "S'inscrire"

### 2. Se connecter

1. Utilisez vos identifiants
2. Cliquez sur "Se connecter"

### 3. Analyser un CV

1. Cliquez sur "Choisir un fichier"
2. Sélectionnez un CV (PDF, DOC ou DOCX - max 5 Mo)
3. Cliquez sur "Analyser le CV"
4. Attendez 20-30 secondes
5. Consultez les résultats !

### 4. Discuter avec le chatbot

1. Après l'analyse, cliquez sur "💬 Discuter avec l'assistant"
2. Posez une question (ex: "Comment améliorer mon CV ?")
3. Recevez des conseils personnalisés !

---

## 🐛 Dépannage

### Problème : "composer: command not found"

**Solution :**
Composer n'est pas dans le PATH. Utilisez le chemin complet :
```bash
C:\xampp\php\composer.phar install
```

Ou téléchargez Composer : https://getcomposer.org/download/

---

### Problème : "php: command not found"

**Solution :**
Ajoutez PHP au PATH système.

**Windows :**
1. Copiez ce chemin : `C:\xampp\php`
2. Recherchez "Variables d'environnement" dans Windows
3. Cliquez sur "Variables d'environnement"
4. Dans "Variables système", sélectionnez "Path"
5. Cliquez sur "Modifier" → "Nouveau"
6. Collez le chemin : `C:\xampp\php`
7. Cliquez sur "OK" partout
8. **Redémarrez votre terminal**

---

### Problème : "Access denied for user 'root'@'localhost'"

**Solution :**
Mot de passe MySQL incorrect.

1. Si vous avez un mot de passe MySQL, modifiez dans `backend/.env` :
```env
   DB_PASSWORD=votre_mot_de_passe
```

2. Si vous n'avez pas de mot de passe (par défaut XAMPP) :
```env
   DB_PASSWORD=
```

---

### Problème : Port 8000 ou 3000 déjà utilisé

**Backend (port 8000) :**
```bash
php artisan serve --port=8001
```
Puis modifiez `frontend/.env` :
```env
REACT_APP_API_URL=http://localhost:8001
```

**Frontend (port 3000) :**
```bash
PORT=3001 npm start
```

---

### Problème : Erreur CORS

**Solution :**
```bash
cd backend
php artisan config:clear
php artisan cache:clear
php artisan config:cache
```

Redémarrez les deux serveurs.

---

### Problème : "Class not found"

**Solution :**
```bash
cd backend
composer dump-autoload
```

---

### Problème : Apache ne démarre pas dans XAMPP

**Solution :**
Le port 80 est déjà utilisé (probablement par Skype ou IIS).

1. Ouvrez XAMPP Control Panel
2. Cliquez sur "Config" à côté d'Apache
3. Sélectionnez "httpd.conf"
4. Cherchez la ligne : `Listen 80`
5. Remplacez par : `Listen 8080`
6. Sauvegardez
7. Redémarrez Apache
8. Accédez à phpMyAdmin via : http://localhost:8080/phpmyadmin

---

### Problème : MySQL ne démarre pas dans XAMPP

**Solution :**
Le port 3306 est utilisé.

1. Vérifiez qu'aucun autre MySQL n'est déjà lancé
2. Ouvrez le Gestionnaire des tâches (Ctrl+Shift+Esc)
3. Cherchez "mysqld.exe"
4. Terminez tous les processus MySQL
5. Relancez MySQL dans XAMPP

---

## 📞 Support

Des problèmes ? Contactez-nous :
- 🐛 Issues GitHub : https://github.com/SersifAbdeljalil/CV_analyse/issues
- 📧 Email : abdosarsif28@gmail.com

---

## 🎉 Fonctionnalités

✅ Inscription et connexion sécurisées  
✅ Upload de CV (PDF, DOC, DOCX)  
✅ Analyse IA avec scores détaillés  
✅ Chatbot intelligent pour conseils personnalisés  
✅ Historique des analyses  
✅ Interface moderne et responsive  

---

## 🛠 Technologies utilisées

**Backend :**
- PHP 8.0+ / Laravel 11
- MySQL
- Laravel Sanctum (authentification)
- Groq API (IA gratuite)

**Frontend :**
- React 18
- Axios
- React Router

---

## 📝 Structure du projet
```
CV_analyse/
├── backend/              # Laravel API
│   ├── app/
│   │   ├── Http/Controllers/
│   │   └── Services/
│   ├── config/
│   ├── database/
│   └── .env
├── frontend/             # React App
│   ├── src/
│   │   └── components/
│   └── .env
└── cv_analyzer.sql       # Base de données
```

---

## ⚡ Commandes rapides

**Backend :**
```bash
cd backend
composer install
php artisan key:generate
php artisan storage:link
php artisan config:cache
php artisan serve
```

**Frontend :**
```bash
cd frontend
npm install
npm start
```

---

**Fait avec ❤️ par Sersif Abdeljalil**

🌟 N'oubliez pas de mettre une étoile sur GitHub si vous aimez ce projet !
