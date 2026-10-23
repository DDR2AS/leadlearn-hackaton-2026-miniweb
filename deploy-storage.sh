#!/usr/bin/env bash
# Crea el storage + contenedor y sube todos los .txt de la carpeta mensajes/.
# Para agregar mensajes: crea otro .txt en mensajes/ y vuelve a ejecutar.
# Uso: ./deploy-storage.sh <resource-group> [location]

set -euo pipefail

RG="${1:?Uso: ./deploy-storage.sh <resource-group> [location]}"
LOCATION="${2:-eastus2}"
DIR="$(cd "$(dirname "$0")" && pwd)"

az group create --name "$RG" --location "$LOCATION" --output none

OUTPUTS=$(az deployment group create \
  --resource-group "$RG" \
  --template-file "$DIR/modules/storage.bicep" \
  --query "[properties.outputs.name.value, properties.outputs.containerName.value, properties.outputs.blobEndpoint.value]" \
  --output tsv | tr -d '\r')
read -r ACCOUNT CONTAINER ENDPOINT <<< "$(echo $OUTPUTS)"

az storage blob upload-batch --auth-mode key \
  --account-name "$ACCOUNT" --destination "$CONTAINER" \
  --source "$DIR/mensajes" --pattern '*.txt' \
  --content-type 'text/plain; charset=utf-8' --overwrite --output none

echo "Storage   : $ACCOUNT"
echo "Contenedor: $CONTAINER"
echo "Endpoint  : $ENDPOINT"
echo "Mensajes  :"
az storage blob list --auth-mode key --account-name "$ACCOUNT" \
  --container-name "$CONTAINER" --query "[].name" --output tsv | sed 's/^/  - /'
