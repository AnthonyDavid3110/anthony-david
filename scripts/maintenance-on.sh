#!/bin/bash

# scripts/maintenance-on.sh
# Active la page de maintenance

echo "🔧 Activation de la page de maintenance..."

# Sauvegarde l'état actuel
git checkout gh-pages
git branch -D backup-before-maintenance 2>/dev/null || true
git checkout -b backup-before-maintenance
git checkout gh-pages

# Supprime tout sauf la page de maintenance
find . -name "*.html" -not -name "maintenance.html" -not -path "./.git/*" -delete
find . -name "*.css" -not -name "maintenance.css" -not -path "./.git/*" -delete
find . -name "*.js" -not -path "./.git/*" -delete
find . -type d -empty -not -path "./.git/*" -delete

# Renomme la page de maintenance en index.html
cp maintenance.html index.html

git add -A
git commit -m "🔧 Maintenance mode activated"
git push origin gh-pages

echo "✅ Page de maintenance activée"