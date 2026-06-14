#!/bin/bash

# ============================================================
# Blank Python Project Creator
# Author: Francois Ernst Venter
# Version: 2.0.0
# ============================================================

set -e

# ------------------------------------------------------------
# Functions
# ------------------------------------------------------------

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

pause() {
    echo
    read -rp "Press Enter to continue..."
}

# ------------------------------------------------------------
# Check Dependencies
# ------------------------------------------------------------

if ! command_exists python3; then
    echo "ERROR: python3 is not installed."
    echo "Please install Python 3 and try again."
    exit 1
fi

# ------------------------------------------------------------
# Get Project Name
# ------------------------------------------------------------

echo
read -rp "Enter a name for the Python Project: " ProjectName

if [[ -z "$ProjectName" ]]; then
    echo "Project name cannot be empty."
    exit 1
fi

# ------------------------------------------------------------
# Check/Create .venvs Directory
# ------------------------------------------------------------

if [[ ! -d "./.venvs" ]]; then

    echo
    echo ".venvs directory does not exist."

    while true; do
        read -rp "Create it now? (yes/no): " answer

        case "${answer,,}" in
            yes|y)
                mkdir -p ./.venvs
                echo "Created .venvs directory."
                break
                ;;
            no|n)
                echo
                echo ".venvs directory is required."
                echo "Exiting..."
                exit 1
                ;;
            *)
                echo "Please answer yes or no."
                ;;
        esac
    done
fi

# ------------------------------------------------------------
# Create Virtual Environment
# ------------------------------------------------------------

echo
echo "Entering .venvs directory..."

cd ./.venvs || exit 1

if [[ -d "$ProjectName" ]]; then
    echo
    echo "ERROR: Virtual environment '$ProjectName' already exists."
    exit 1
fi

echo
echo "Creating virtual environment '$ProjectName'..."

python3 -m venv "$ProjectName"

echo "Virtual environment created successfully."

# ------------------------------------------------------------
# Activate Environment
# ------------------------------------------------------------

echo
echo "Activating virtual environment..."

source "./$ProjectName/bin/activate"

# ------------------------------------------------------------
# Upgrade pip
# ------------------------------------------------------------

echo
echo "Updating pip..."

python -m pip install --upgrade pip

echo
echo "pip updated successfully."

# ------------------------------------------------------------
# Finished
# ------------------------------------------------------------

echo
echo "========================================"
echo "Project Name : $ProjectName"
echo "Location     : $(pwd)/$ProjectName"
echo "Python       : $(python --version)"
echo "========================================"
echo
echo "Virtual environment is active."
echo
echo "To activate it later:"
echo "source ./.venvs/$ProjectName/bin/activate"
echo
echo "Happy coding!"
echo
echo "Written by Francois Ernst Venter"
