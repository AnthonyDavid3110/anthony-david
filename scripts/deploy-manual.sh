#!/bin/bash

# scripts/deploy-manual.sh
# Déploiement manuel si besoin

echo "🚀 Déploiement manuel du site..."

# Build Hugo
hugo --minify

# Deploy vers gh-pages
git checkout gh-pages
git pull origin gh-pages

# Sauvegarde la page de maintenance
cp maintenance.html maintenance-backup.html
cp maintenance.css maintenance-backup.css

# Copie les nouveaux fichiers
cp -r public/* .
rm -rf public

# Restaure les fichiers de maintenance
cp maintenance-backup.html maintenance.html
cp maintenance-backup.css maintenance.css
rm maintenance-backup.*

git add -A
git commit -m "🚀 Manual deployment $(date)"
git push origin gh-pages

git checkout main
echo "✅ Déploiement manuel terminé"