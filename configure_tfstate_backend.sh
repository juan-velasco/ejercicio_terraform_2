#!/bin/bash

########################################################################################################################
# ESTE SCRIPT LO EJECUTAMOS PARA CREAR LA CUENTA DE ALMACENAMIENTO DEL ESTADO EN AZURE
# UNA VEZ EJECUTADO NOS DEVOLVERÁ EL access_key, que podemos utilizar como variable de entorno con el comando:
# export ARM_ACCESS_KEY=<storage access key>
#
# Más información en https://docs.microsoft.com/es-es/azure/developer/terraform/store-state-in-azure-storage
########################################################################################################################

RESOURCE_GROUP_NAME=tstatesw
STORAGE_ACCOUNT_NAME=tstatesw$RANDOM
CONTAINER_NAME=tstatesw

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location westeurope

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query [0].value -o tsv)

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY

echo "storage_account_name: $STORAGE_ACCOUNT_NAME"
echo "container_name: $CONTAINER_NAME"
echo "access_key: $ACCOUNT_KEY"