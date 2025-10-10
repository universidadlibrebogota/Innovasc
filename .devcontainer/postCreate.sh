#!/usr/bin/env bash
set -euo pipefail

echo "[postCreate] start"

# Detecta el root del repo aunque esté en subcarpeta
WF="${WORKSPACE_FOLDER:-/workspaces/${localWorkspaceFolderBasename:-$(ls /workspaces | head -n1)}}"
for d in "$WF" "$WF"/*; do
  if [ -d "$d/backend-python" ] && [ -d "$d/api-gateway" ] && [ -d "$d/frontend" ]; then
    WF="$d"; break
  fi
done
cd "$WF"
echo "[postCreate] WF=$WF"

# ---- Deps Python (backend) ----
echo "[postCreate] Python deps"
python3 -m pip install --upgrade pip
python3 -m pip install -r backend-python/requirements.txt

# ---- Deps Node (frontend) ----
echo "[postCreate] Node deps (frontend)"
cd frontend
if [ -f package-lock.json ]; then npm ci || npm install; else npm install; fi
cd ..

# ---- Deps Node (gateway) ----
echo "[postCreate] Node deps (gateway)"
cd api-gateway
if [ -f package-lock.json ]; then npm ci || npm install; else npm install; fi
npm run build
cd ..

# ---- Espera DB y carga SQL ----
echo "[postCreate] Waiting for MySQL (db)..."
for i in {1..60}; do
  if mysqladmin ping -h db -uroot --silent 2>/dev/null; then
    echo "  MySQL ready"; break
  fi
  echo "  ... $i/60"; sleep 2
done

if [ -f database/inovaasc.sql ]; then
  echo "[postCreate] Importing database/inovaasc.sql"
  mysql -h db -uroot -e "CREATE DATABASE IF NOT EXISTS inovaasc CHARACTER SET utf8mb4;"
  mysql -h db -uroot inovaasc < database/inovaasc.sql || true
else
  echo "[postCreate] database/inovaasc.sql NOT FOUND (skip import)"
fi

# ---- Asegura admin/admin123 si no existe ----
echo "[postCreate] Ensure admin user"
python3 - <<'PY'
from passlib.context import CryptContext
import subprocess
pwd = CryptContext(schemes=['bcrypt']).hash('admin123')
sql = f"""INSERT INTO usuarios (Usuario,Nombre,Email,Password,ID_Permission)
SELECT 'admin','Admin','admin@example.com','{pwd}',1
WHERE NOT EXISTS (SELECT 1 FROM usuarios WHERE Usuario='admin');"""
subprocess.run(["mysql","-h","db","-uroot","inovaasc","-e",sql], check=False)
PY

echo "[postCreate] done"
