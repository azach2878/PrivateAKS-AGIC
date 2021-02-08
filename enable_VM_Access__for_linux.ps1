$VMSS         = 'aks-agentpool-11552782-vmss'
$RG           = 'MC_AKS_AKS_EASTUS'
$ExtName      = 'VMAccessForLinux'
$Publisher    = 'Microsoft.OSTCExtensions'

Add-AzVmssExtension -VirtualMachineScaleSet $VMSS -Name $ExtName -Publisher $Publisher -Type $ExtType -TypeHandlerVersion $ExtVer -AutoUpgradeMinorVersion $True