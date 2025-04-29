// Connect an existing VM to Log Analytics by installing Azure Monitor Agent
param vmName string
param workspaceResourceId string
param location string = resourceGroup().location

// Reference existing Virtual Machine
resource vm 'Microsoft.Compute/virtualMachines@2022-03-01' existing = {
  name: vmName
}

// Install Azure Monitor Agent Extension on the VM
resource extension 'Microsoft.Compute/virtualMachines/extensions@2022-03-01' = {
  parent: vm
  name: 'AzureMonitorWindowsAgent'
  properties: {
    publisher: 'Microsoft.Azure.Monitor'
    type: 'AzureMonitorWindowsAgent'
    typeHandlerVersion: '1.0'
    autoUpgradeMinorVersion: true
    settings: {
      workspaceResourceId: workspaceResourceId // Connect VM logs to this workspace
    }
  }
}
