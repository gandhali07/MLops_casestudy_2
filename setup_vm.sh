#!/bin/bash

set -e

echo "======================================"
echo " AI Meal Planner - VM Setup"
echo "======================================"

PROJECT_DIR="$HOME/MLops_casestudy_2"

echo "[1/5] Updating package information..."
sudo apt update

echo "[2/5] Installing Python virtual environment support..."
sudo apt install -y python3.10-venv

echo "[3/5] Creating Python virtual environment..."
cd "$PROJECT_DIR"

if [ ! -d ".venv" ]; then
    python3 -m venv .venv
fi

source .venv/bin/activate

echo "[4/5] Upgrading pip and installing CPU PyTorch..."
python -m pip install --upgrade pip
python -m pip install torch --index-url https://download.pytorch.org/whl/cpu

echo "[5/5] Installing application requirements..."
python -m pip install -r requirements.txt

echo ""
echo "======================================"
echo " Setup completed successfully!"
echo "======================================"
echo "Python:"
python --version
echo "PyTorch:"
python -c "import torch; print(torch.__version__); print('CUDA available:', torch.cuda.is_available())"
