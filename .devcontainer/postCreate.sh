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



echo "[postCreate] Asegurando cliente mysql y admin"
command -v mysql || { echo "mysql client no disponible"; exit 1; }

# Espera DB (no rompe el script aunque falle puntual)
for i in {1..60}; do
  if mysqladmin ping -h db -uroot --silent 2>/dev/null; then
    echo "  MySQL OK"; break
  fi
  echo "  Esperando MySQL... ($i/60)"; sleep 2
done

# Importar SQL si existe (no aborta si ya está importado)
if [ -f database/inovaasc.sql ]; then
  mysql -h db -uroot -e "CREATE DATABASE IF NOT EXISTS inovaasc CHARACTER SET utf8mb4;" || true
  mysql -h db -uroot inovaasc < database/inovaasc.sql || true
fi

# Crear admin si no existe (cumple NOT NULL de Nombre/Email)
HASH=$(python3 - <<'PY'
from passlib.context import CryptContext
print(CryptContext(schemes=['bcrypt']).hash('admin123'))
PY
)
mysql -h db -uroot inovaasc -e "INSERT INTO usuarios (Usuario,Nombre,Email,Password,ID_Permission)
SELECT 'admin','Admin','admin@example.com','${HASH}',1
WHERE NOT EXISTS (SELECT 1 FROM usuarios WHERE Usuario='admin');" || true
