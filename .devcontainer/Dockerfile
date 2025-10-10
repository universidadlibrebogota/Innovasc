FROM mcr.microsoft.com/devcontainers/javascript-node:0-18

# Herramientas necesarias para postCreate.sh
RUN apt-get update && \
    apt-get install -y python3 python3-pip default-mysql-client curl && \
    rm -rf /var/lib/apt/lists/*

# pm2 (opcional)
RUN npm i -g pm2
