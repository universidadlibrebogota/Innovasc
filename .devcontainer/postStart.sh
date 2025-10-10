#!/usr/bin/env bash
set -euo pipefail
WF="${WORKSPACE_FOLDER:-/workspaces/$(ls /workspaces | head -n1)}"
echo "[postStart] Matando procesos previos si existen"
pkill -f "uvicorn app.main" || true
pkill -f "node dist/index.js" || true
pkill -f "next dev" || true
echo "[postStart] Iniciando backend (FastAPI) en 0.0.0.0:8000"
cd "$WF/backend-python"
nohup uvicorn app.main:app --host 0.0.0.0 --port 8000 > /tmp/backend.log 2>&1 &
echo "[postStart] Iniciando gateway (Express) en 0.0.0.0:4000"
cd "$WF/api-gateway"
export BACKEND_URL="http://127.0.0.1:8000"
export JWT_SECRET="dev-secret"
export CORS_ORIGIN="https://3000-${CODESPACE_NAME}.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
nohup node dist/index.js > /tmp/gateway.log 2>&1 &
echo "[postStart] Iniciando frontend (Next) en 0.0.0.0:3000"
cd "$WF/frontend"
export NEXT_PUBLIC_API_URL="https://4000-${CODESPACE_NAME}.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
nohup npx next dev -H 0.0.0.0 -p 3000 > /tmp/frontend.log 2>&1 &
sleep 4
echo "[postStart] Creando admin por defecto (si corresponde)"
curl -s -X POST "https://4000-${CODESPACE_NAME}.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}/api/auth/register-admin"   -H "Content-Type: application/json"   -d '{"Usuario":"admin","Password":"admin123"}' >/dev/null 2>&1 || true
echo "[postStart] Servicios iniciados. Puertos 3000 / 4000 / 8000"
