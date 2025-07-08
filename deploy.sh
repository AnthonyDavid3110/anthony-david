#!/bin/bash

# Stop on error
set -e

# Configuration
BRANCH="gh-pages"
BUILD_DIR="public"
TMP_DIR="deploy-tmp"
COMMIT_MSG="Déploiement du site $(date '+%Y-%m-%d %H:%M:%S')"

echo "📦 Génération du site..."
hugo --minify

echo "📁 Sauvegarde temporaire..."
rm -rf $TMP_DIR
cp -r $BUILD_DIR $TMP_DIR

echo "🔀 Passage à la branche $BRANCH..."
git checkout $BRANCH

echo "🧹 Nettoyage de l'ancien site..."
find . -mindepth 1 ! -regex '^./\.git\(/.*\)?' -delete

echo "📤 Copie du nouveau site..."
cp -r $TMP_DIR/* .

echo "✅ Commit et push..."
git add .
git commit -m "$COMMIT_MSG"
git push origin $BRANCH

echo "🧽 Nettoyage temporaire..."
rm -rf $TMP_DIR

echo "↩️ Retour sur la branche main..."
git checkout main

echo "🚀 Déploiement terminé avec succès !"
