// setup_monitoring.bicep

@description('The name of the existing virtual machine to onboard to Azure Monitor')
param vmName string

@description('Resource ID of the Log Analytics workspace to connect the VM to')
param workspaceResourceId string

@description('The location for the deployment')
param location string = resourceGroup().location

resource vm 'Microsoft.Compute/virtualMachines@2023-03-01' existing = {
  name: vmName
}

// Deploy Azure Monitor Agent extension to the existing VM
resource azureMonitorAgentExtension 'Microsoft.Compute/virtualMachines/extensions@2023-03-01' = {
  name: 'AzureMonitorWindowsAgent'
  parent: vm
  location: location
  properties: {
    publisher: 'Microsoft.Azure.Monitor'
    type: 'AzureMonitorWindowsAgent'
    typeHandlerVersion: '1.0'
    autoUpgradeMinorVersion: true
    settings: {
      workspaceResourceId: workspaceResourceId
    }
  }
}
