#!/bin/bash

#V1.0.0
# Function to check if a command is available.
command_exists() {
  command -v \$1 >/dev/null 2>$1
}

# Ask the user for the name of the project.
echo "Enter a name for you Flask project:"
read ProjectName

# Check if the directory .venvs exists.
if [ ! -d "./.venvs" ]; then
  # If not, then ask the user if they want to create the directory.
  while true; do
    echo "❌ .venvs directory does not exist. ❌"
    echo "Do you want to create it? (yes|no)"
    read answer

  # If the answer is yes, then create the directory and break the loop.
    if [ "$answer" = "yes" ]; then
      mkdir ./.venvs
      break
    elif [ "$answer" = "no" ]; then
      # If the answer is no, then exit the script.
      echo "❌ .venvs directory is required. ❌"
      clear
      echo "Exiting... 👋🏼"
      exit 1
    else
      echo "Invalid input."
      echo "🙅🏼‍♂️ Please answer only yes or no."
    fi
done
fi

clear

# Navigate to the directory where you want to create the virtual environment
echo "🔎 Entering '.venv' Directory..."
cd ./.venvs/

# Create the virtual environment
clear && echo "🏗️ Creating the virtual environment '$ProjectName'..."
python3 -m venv ./$ProjectName
clear && echo "✅ The virtual environment $ProjectName has been created. ✅"

# Activate the virtual environment
cd $ProjectName
clear && echo "✅ Activating  " && source ./bin/activate

# Update PIP so not to run into funny business.
echo "🔼 Updating PIP..."
python3 -m pip install --upgrade pip
clear && echo "✅ PIP has finished updating..."

# Install Django
echo "📄 Installing Flask and Dependancies..."
pip install Flask -s
clear && echo "✅ Flask installed, installing Flask_Migrate..."
pip install Flask_Migrate -s
clear && echo "✅ Flask_Migrate installed, installing flask_sqlalchemy..."
pip install flask_sqlalchemy -s 
clear && echo "✅ flask_sqlalchemy installed, installing Flask_WTF..."
pip install Flask_WTF -s
clear && echo "✅ Flask_WTF installed, installing SQLAlchemy..."
pip install SQLAlchemy -s
clear && echo "✅SQLAlchemy installed, installing WTForms..."
pip install WTForms -s
clear && echo "✅ WTForms installed, Flask has been installed..." && echo "✅ Install finished, exiting..."

# Go back to the root folder.
cd ..
cd ..

clear && echo "👋🏼 Bye bye :)"
