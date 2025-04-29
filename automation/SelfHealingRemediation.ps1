# Automatically remediate VM threats by restarting the VM
 
 param(
   [string]$VMName,              # Name of the existing VM
   [string]$ResourceGroupName     # Resource Group containing the VM
 )
 
 Write-Output "Starting Self-Healing Remediation for VM: $VMName in Resource Group: $ResourceGroupName..."
 
 # Authenticate inside Azure Automation (Managed Identity)
 Login-AzAccount -Identity
 
 # Restart the VM as a basic recovery action
 Restart-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName -Force
 
 Write-Output "VM Restarted Successfully as part of Auto-Remediation."
