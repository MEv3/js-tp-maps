[![Open in VS Code](https://img.shields.io/badge/Open%20in-VS%20Code-007ACC?logo=visualstudiocode&logoColor=white)](https://vscode.dev/github/CIEL2-JR-WEB/maps)
# 📚 Sujet de l'activité

<div align="center">
  <a href="https://docs.google.com/document/d/1_f3wa046GHqpQVQXHYsbJi_vZGt_tLwtoiRUXwrdVQ8/edit?usp=sharing">
    <img src="https://img.icons8.com/color/96/google-docs.png" width="80"/>
    <br/>
    <b>Cliquez ici pour accéder au sujet</b>
  </a>
</div>




# ⚙️🐳 Environnement pour l'activité 
## ✨ Fonctionnalités 

      🔄 Détection automatique de l'environnement (Local/Codespaces/GitPod)
      🐛 Xdebug configuré et prêt à l'emploi
      🐘 PHP 8.2 avec extensions PDO MySQL
      🌐 Nginx comme serveur web
      🐬 MySQL 8 avec persistance des données
      🔧 phpMyAdmin pour gérer la base de données
      📦 Docker Compose pour orchestrer les services

## 🛠️ Prérequis

- Docker
- Docker Compose
- VS Code (recommandé pour le débogage)

##  📁 Project Structure

<pre>
your-project/
├── .vscode/
│   ├── extensions.json       # Recommends extensions
│   └── launch.json           # Debug configuration
├── code/
│   └── ex1
│         └── ex1-1.html
│         └── ex1-2.html
│   └── ex2
│         └── ex2-1.html
│         └── ex2-2.html
│   └── ...
│         └── ...
│         └── ...
│   └── Synthese sans backEnd
│         └── courses.json
│         └── index.html
│   └── Synthese avec backEnd
│         └── courses.json
│         └── index.html
│         └── traitement.php
│   
├── Dockerfile
├── docker-compose.yml
└── nginx.conf
└── README.md
</pre>

## 🚀 Démarrage
1. Cloner le dépôt
```bash
   git clone <votre-repo>
   cd your-project
```
2. Lancer les conteneurs Docker
```docker-compose up -d```

3. Ouvrir le projet dans VS Code
```code .```


## 🌐 Points d'accès

| Service | URL | Description |
|---------|-----|-------------|
| 🏠 Application | http://localhost:8090 | Page d'accueil |
| 🗄️ phpMyAdmin | http://localhost:8081 | Interface MySQL |

### 🔌 Debugger avec Xdebug
- Lancer la tâche 'Listen for Xdebug'
- ajouter un breakpoint dans le fichier `php` à debugger
- Lancer un browser avec l'adresse de l'application 🏠
- Rendez vous dans le script php où Xdebug à stopper l'execution afin de consulter l'état des variables.
- Identifier la cause du bug...

| Service | Hôte | Port | Identifiants |
|---------|------|------|--------------|
| 🐛 Xdebug | `localhost` | `9003` | (VS Code) |



## 🐬 Connexion à MySQL
### Informations de connexion
- **Utilisateur**: user
- **Mot de passe**: password
- **Base de données**: appdb
- **Root password**: root (pour phpMyAdmin ou connexion root)
### Depuis un terminal
```mysql -h 127.0.0.1 -P 3306 -u user -p```
### Depuis MySQL Workbench
1. Ouvrir MySQL Workbench
2. Cliquer sur le bouton **"+"** à côté de "MySQL Connections"
3. Remplir les informations de connexion :
   - **Connection Name**: Docker PHP App (ou un nom de votre choix)
   - **Hostname**: 127.0.0.1
   - **Port**: 3306
   - **Username**: user


