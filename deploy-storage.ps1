# Crea el storage + contenedor y sube mensaje.txt.
# Uso: ./deploy-storage.ps1 -ResourceGroup rg-miniweb

param(
    [Parameter(Mandatory)] [string] $ResourceGroup,
    [string] $Location = 'eastus2'
)

$ErrorActionPreference = 'Stop'

az group create --name $ResourceGroup --location $Location --output none

$out = az deployment group create --resource-group $ResourceGroup `
    --template-file "$PSScriptRoot/modules/storage.bicep" `
    --query properties.outputs --output json | ConvertFrom-Json

az storage blob upload --auth-mode key `
    --account-name $out.name.value --container-name $out.containerName.value `
    --name mensaje.txt --file "$PSScriptRoot/mensaje.txt" --overwrite --output none

Write-Host "Storage   : $($out.name.value)"
Write-Host "Contenedor: $($out.containerName.value)"
Write-Host "Endpoint  : $($out.blobEndpoint.value)"
