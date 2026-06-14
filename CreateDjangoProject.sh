#!/usr/bin/env bash

# ==========================================================

# Django Project Generator

# Version: 3.0.0

# Author: Francois Ernst Venter

# ==========================================================

set -euo pipefail

# ----------------------------------------------------------

# Functions

# ----------------------------------------------------------

command_exists() {
command -v "$1" >/dev/null 2>&1
}

error_exit() {
echo "❌ ERROR: $1"
exit 1
}

success() {
echo "✅ $1"
}

# ----------------------------------------------------------

# Prerequisites

# ----------------------------------------------------------

clear
echo "======================================"
echo "      Django Project Generator"
echo "======================================"
echo

command_exists python3 || error_exit "Python3 is not installed."

# ----------------------------------------------------------

# Project Name

# ----------------------------------------------------------

while true; do
read -rp "Enter Django project name: " ProjectName

```
if [[ -z "$ProjectName" ]]; then
    echo "Project name cannot be empty."
    continue
fi

if [[ "$ProjectName" =~ ^[a-zA-Z0-9_-]+$ ]]; then
    break
fi

echo "Use only letters, numbers, underscores and hyphens."
```

done

# ----------------------------------------------------------

# Virtual Environment Folder

# ----------------------------------------------------------

mkdir -p .venvs

if [ -d ".venvs/$ProjectName" ]; then
error_exit "Virtual environment already exists."
fi

if [ -d "$ProjectName" ]; then
error_exit "Project directory already exists."
fi

# ----------------------------------------------------------

# Create Virtual Environment

# ----------------------------------------------------------

echo
echo "🏗️ Creating virtual environment..."

python3 -m venv ".venvs/$ProjectName"

success "Virtual environment created."

# ----------------------------------------------------------

# Activate Environment

# ----------------------------------------------------------

# shellcheck disable=SC1091

source ".venvs/$ProjectName/bin/activate"

success "Environment activated."

# ----------------------------------------------------------

# Update Python Tooling

# ----------------------------------------------------------

echo
echo "📦 Updating Python tools..."

python -m pip install --upgrade 
pip 
setuptools 
wheel

success "Python tools updated."

# ----------------------------------------------------------

# Install Django

# ----------------------------------------------------------

echo
echo "📦 Installing Django..."

pip install django

success "Django installed."

# ----------------------------------------------------------

# Create Project

# ----------------------------------------------------------

echo
echo "🏗️ Creating Django project..."

django-admin startproject "$ProjectName"

success "Project created."

# ----------------------------------------------------------

# Enter Project Root

# ----------------------------------------------------------

cd "$ProjectName"

# ----------------------------------------------------------

# Create Folder Structure

# ----------------------------------------------------------

echo
echo "📁 Creating project folders..."

mkdir -p apps
mkdir -p templates/includes
mkdir -p static/css
mkdir -p static/js
mkdir -p static/images
mkdir -p media
mkdir -p logs

success "Folder structure created."

# ----------------------------------------------------------

# Create requirements.txt

# ----------------------------------------------------------

pip freeze > requirements.txt

success "requirements.txt created."

# ----------------------------------------------------------

# Create .gitignore

# ----------------------------------------------------------

cat > .gitignore <<EOF
**pycache**/
*.pyc
*.sqlite3

media/
logs/

.env

.vscode/
.idea/

.venvs/
EOF

success ".gitignore created."

# ----------------------------------------------------------

# Create .env

# ----------------------------------------------------------

cat > .env <<EOF
DEBUG=True
SECRET_KEY=CHANGE_ME
ALLOWED_HOSTS=localhost,127.0.0.1
EOF

success ".env created."

# ----------------------------------------------------------

# Create Base Template

# ----------------------------------------------------------

cat > templates/base.html <<EOF

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{% block title %}Django App{% endblock %}</title>
</head>
<body>

{% block content %}
{% endblock %}

</body>
</html>
EOF

success "base.html created."

# ----------------------------------------------------------

# Summary

# ----------------------------------------------------------

echo
echo "======================================"
echo "🎉 Project Created Successfully!"
echo "======================================"
echo
echo "Project Name:"
echo "  $ProjectName"
echo
echo "Virtual Environment:"
echo "  .venvs/$ProjectName"
echo
echo "Activate Later:"
echo "  source .venvs/$ProjectName/bin/activate"
echo
echo "Run Development Server:"
echo "  cd $ProjectName"
echo "  python manage.py runserver"
echo
echo "Generated Structure:"
echo
tree . 2>/dev/null || true
echo
echo "Happy Coding! 🚀"
