#!/bin/bash

if [ ! -f "/data/senhas.txt" ]; then
  echo "Arquivo senhas.txt não encontrado!"
  exit 1
fi

echo "[+] Gerando arquivo de hashes SHA256..."

> /data/senhas.hash
contador=1
while IFS= read -r senha; do
  hash=$(echo -n "$senha" | sha256sum | awk '{print $1}')
  echo "usuario$contador:$hash" >> /data/senhas.hash
  echo "usuario$contador:$hash  # senha original: $senha"
  ((contador++))
done < /data/senhas.txt

echo "[+] Iniciando ataque com John the Ripper..."
/opt/john/run/john --wordlist=/rockyou.txt /data/senhas.hash --format=raw-sha256
