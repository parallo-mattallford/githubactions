param environmentName string
param locationCode string
param location string

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-example1-${environmentName}-${locationCode}'
  location: location
}

module vNet 'virtualnetwork.bicep' = {
  name: 'vnet-${environmentName}-${locationCode}'
  scope: resourceGroup(rg.name)
  params: {
    vNetName: 'vnet-${environmentName}-${locationCode}'
    location: location
  }
}

module stgAccount 'storageaccount.bicep' = {
  name: 'stgparallodemo${environmentName}${locationCode}'
  scope: resourceGroup(rg.name)
  params: {
    storageAccountName: 'stgparallodemo${environmentName}${locationCode}'
    location: location
  }
}
