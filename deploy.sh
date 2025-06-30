#!/bin/bash

# Arrêt si erreur
set -e

# Variables
BRANCH=gh-pages
BUILD_DIR=public
TMP_DIR=deploy-tmp

# Génère le site avec Hugo
hugo --minify

# Copie le contenu généré dans un dossier temporaire
rm -rf $TMP_DIR
cp -r $BUILD_DIR $TMP_DIR

# Bascule sur la branche gh-pages
git checkout $BRANCH

# Supprime tout sauf .git (important pour ne pas perdre le repo)
find . ! -name '.git' ! -name '.' -exec rm -rf {} +

# Copie les fichiers générés depuis le dossier temporaire
cp -r $TMP_DIR/* .

# Ajoute et pousse
git add .
git commit -m "Déploiement du site $(date '+%Y-%m-%d %H:%M:%S')"
git push origin $BRANCH

# Nettoyage
rm -rf $TMP_DIR

# Retour sur main pour continuer à développer
git checkout main
