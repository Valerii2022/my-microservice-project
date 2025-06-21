#!/bin/bash

set -e

echo " Перевірка та встановлення DevOps-інструментів..."

# Встановлення Docker
if ! command -v docker &> /dev/null; then
  echo "Встановлення Docker..."
  sudo apt update
  sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker.gpg
  sudo add-apt-repository \
    "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable"
  sudo apt update
  sudo apt install -y docker-ce
else
  echo " Docker вже встановлений"
fi

# Встановлення Docker Compose
if ! command -v docker-compose &> /dev/null; then
  echo "Встановлення Docker Compose..."
  sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.6/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
else
  echo " Docker Compose вже встановлений"
fi

# Встановлення Python 3.9+
PYTHON_VERSION=$(python3 -V 2>&1 | awk '{print $2}')
if [[ "$PYTHON_VERSION" < "3.9" ]]; then
  echo "Встановлення Python 3.9+..."
  sudo apt update
  sudo apt install -y python3 python3-pip python3-venv
else
  echo "Python $PYTHON_VERSION вже встановлений"
fi

# Встановлення Django
if ! python3 -m pip show django &> /dev/null; then
  echo "Встановлення Django..."
  python3 -m pip install --user --break-system-packages django
else
  echo " Django вже встановлений"
fi

echo " Усі DevOps інструменти встановлено!"

