#!/bin/bash

# scripts/deploy-manual.sh
# Déploiement manuel si besoin

echo "🚀 Déploiement manuel du site..."

# Vérifier qu'on est sur main
if [ "$(git branch --show-current)" != "main" ]; then
    echo "❌ Vous devez être sur la branche main"
    exit 1
fi

# Stash les changements locaux s'il y en a
git stash push -m "Deploy script stash $(date)"

# Build Hugo
echo "🔨 Building Hugo site..."
hugo --minify

if [ ! -d "public" ]; then
    echo "❌ Le build Hugo a échoué - dossier public non créé"
    exit 1
fi

# Deploy vers gh-pages
echo "📤 Déploiement vers gh-pages..."
git checkout gh-pages
git pull origin gh-pages

# Sauvegarde les fichiers de maintenance
cp maintenance.html maintenance-backup.html 2>/dev/null || true
cp maintenance.css maintenance-backup.css 2>/dev/null || true

# Supprime l'ancien contenu (sauf maintenance et .git)
find . -maxdepth 1 -name "*.html" -not -name "maintenance*" -delete
find . -maxdepth 1 -name "*.css" -not -name "maintenance*" -delete
find . -maxdepth 1 -name "*.js" -delete
find . -maxdepth 1 -type d -not -name ".git" -not -name "." -exec rm -rf {} + 2>/dev/null || true

# Copie les nouveaux fichiers depuis main
git checkout main -- public
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

# Restaure le stash s'il y en avait un
git stash pop 2>/dev/null || true

echo "✅ Déploiement manuel terminé"