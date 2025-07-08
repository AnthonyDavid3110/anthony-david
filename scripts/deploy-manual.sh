#!/bin/bash

# scripts/deploy-manual.sh
# Déploiement manuel si besoin

echo "🚀 Déploiement manuel du site..."

# Build Hugo
hugo --minify

# Deploy vers gh-pages
git checkout gh-pages
git pull origin gh-pages

# Sauvegarde les fichiers de maintenance
cp maintenance.html maintenance-backup.html 2>/dev/null || true
cp maintenance.css maintenance-backup.css 2>/dev/null || true

# Supprime l'ancien contenu (sauf maintenance)
find . -name "*.html" -not -name "maintenance*" -not -path "./.git/*" -delete
find . -name "*.css" -not -name "maintenance*" -not -path "./.git/*" -delete
find . -name "*.js" -not -path "./.git/*" -delete
find . -type d -empty -not -path "./.git/*" -delete

# Copie les nouveaux fichiers
cp -r public/* .
rm -rf public

# Restaure les fichiers de maintenance
cp maintenance-backup.html maintenance.html 2>/dev/null || true
cp maintenance-backup.css maintenance.css 2>/dev/null || true
rm maintenance-backup.* 2>/dev/null || true

git add -A
git commit -m "🚀 Manual deployment $(date)"
git push origin gh-pages

git checkout main
echo "✅ Déploiement manuel terminé"