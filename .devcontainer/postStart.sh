#!/usr/bin/env bash
set -e

# Detecta el root del repo
WF="${WORKSPACE_FOLDER:-/workspaces/${localWorkspaceFolderBasename:-$(ls /workspaces | head -n1)}}"
for d in "$WF" "$WF"/*; do
  if [ -d "$d/backend-python" ] && [ -d "$d/api-gateway" ] && [ -d "$d/frontend" ]; then
    WF="$d"; break
  fi
done
cd "$WF"

echo "[postStart] Killing previous dev servers (if any)"
pkill -f "uvicorn app.main" || true
pkill -f "node dist/index.js" || true
pkill -f "ts-node-dev" || true
pkill -f "next dev" || true

echo "[postStart] Starting backend (FastAPI) on 0.0.0.0:8000"
(cd backend-python && nohup uvicorn app.main:app --host 0.0.0.0 --port 8000 > /tmp/backend.log 2>&1 &)

echo "[postStart] Starting gateway (Express) on 0.0.0.0:4000"
(cd api-gateway && nohup node dist/index.js > /tmp/gateway.log 2>&1 &)

echo "[postStart] Starting frontend (Next) on 0.0.0.0:3000"
(cd frontend && nohup npx next dev -H 0.0.0.0 -p 3000 > /tmp/frontend.log 2>&1 &)

echo "[postStart] Services up. Ports: 3000 (Front) / 4000 (Gateway) / 8000 (Backend)"
