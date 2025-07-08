#!/bin/bash

# scripts/maintenance-off.sh
# Désactive la page de maintenance et redéploie

echo "🚀 Désactivation de la page de maintenance..."

# Déclenche un nouveau déploiement
git checkout main
git commit --allow-empty -m "🚀 Trigger deployment after maintenance"
git push origin main

echo "✅ Déploiement déclenché - la maintenance sera désactivée dans quelques minutes"
