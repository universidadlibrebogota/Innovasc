#!/usr/bin/env bash
set -euo pipefail
WF="${WORKSPACE_FOLDER:-/workspaces/$(ls /workspaces | head -n1)}"
cd "$WF"
echo "[postCreate] Python deps (backend)"
pip3 install --upgrade pip
pip3 install -r backend-python/requirements.txt
echo "[postCreate] Node deps (frontend)"
cd "$WF/frontend"
npm install
echo "[postCreate] Node deps (gateway)"
cd "$WF/api-gateway"
npm install
npm run build
echo "[postCreate] Esperando a MySQL (db) ..."
for i in {1..60}; do
  if mysqladmin ping -h db -uroot --silent 2>/dev/null; then
    echo "  MySQL OK"
    break
  fi
  echo "  Esperando MySQL... ($i/60)"; sleep 2
done
echo "[postCreate] Importando base de datos (si corresponde)"
cd "$WF"
if [ -f database/inovaasc.sql ]; then
  mysql -h db -uroot -e "CREATE DATABASE IF NOT EXISTS inovaasc CHARACTER SET utf8mb4;"
  mysql -h db -uroot inovaasc < database/inovaasc.sql || true
else
  echo "  (No se encontró database/inovaasc.sql)"
fi
