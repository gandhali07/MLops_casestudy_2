#!/bin/bash
set -e

PROJECT_DIR="$HOME/MLops_casestudy_2"
SERVICE_FILE="/etc/systemd/system/meal-planner.service"
ENV_DIR="/etc/meal-planner"
ENV_FILE="$ENV_DIR/meal-planner.env"

echo "======================================"
echo " AI Meal Planner - Service Installer"
echo "======================================"

if [ ! -d "$PROJECT_DIR/.venv" ]; then
    echo "ERROR: Python environment not found."
    echo "Run ./setup_vm.sh first."
    exit 1
fi

sudo mkdir -p "$ENV_DIR"

if [ ! -f "$ENV_FILE" ]; then
    echo "ERROR: $ENV_FILE does not exist."
    echo "Create the protected HF_TOKEN environment file first."
    exit 1
fi

sudo chmod 600 "$ENV_FILE"
sudo chown root:root "$ENV_FILE"

sudo tee "$SERVICE_FILE" > /dev/null <<'EOF'
[Unit]
Description=AI Meal Planner Gradio Application
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=student-admin
Group=student-admin
WorkingDirectory=/home/student-admin/MLops_casestudy_2
EnvironmentFile=/etc/meal-planner/meal-planner.env
Environment=PYTHONUNBUFFERED=1
ExecStart=/home/student-admin/MLops_casestudy_2/.venv/bin/python /home/student-admin/MLops_casestudy_2/app.py
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable meal-planner
sudo systemctl restart meal-planner

echo ""
echo "Service installed successfully."
sudo systemctl --no-pager --full status meal-planner
