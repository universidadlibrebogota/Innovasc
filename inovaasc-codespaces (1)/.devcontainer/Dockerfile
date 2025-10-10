FROM mcr.microsoft/vscode/devcontainers/javascript-node:0-18

# Python 3 + pip + MySQL client + curl
RUN apt-get update &&     apt-get install -y python3 python3-pip default-mysql-client curl &&     rm -rf /var/lib/apt/lists/*

RUN npm i -g pm2
