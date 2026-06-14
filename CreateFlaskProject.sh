#!/usr/bin/env bash

set -euo pipefail

read -rp "Enter Flask project name: " ProjectName

mkdir -p .venvs

cd .venvs

if [ -d "$ProjectName" ]; then
    echo "❌ $ProjectName already exists."
    exit 1
fi

echo "🏗️ Creating virtual environment..."
python3 -m venv "$ProjectName"

cd "$ProjectName"

source bin/activate

echo "🔼 Updating pip..."
python -m pip install --upgrade pip

echo "📦 Installing packages..."
pip install \
    Flask \
    Flask-Migrate \
    Flask-SQLAlchemy \
    Flask-WTF \
    SQLAlchemy \
    WTForms

pip freeze > requirements.txt

echo "✅ Environment created successfully!"
echo
echo "Activate later with:"
echo "source .venvs/$ProjectName/bin/activate"
