# Run this script after creating your AKS cluster Node.
# You need to create a new Virtual Network Link in your Private DNS in the AKS MC_ Resource group..... Get the DNS Name which was created when creating your aks. 

$DNSZone        = "663eb315-5878-4381-95ad-405a329052b8.privatelink.eastus2.azmk8s.io"
$DNSZoneRG      = "MC_aks_aks_eastus2"
$TargetvNet     = Get-AzVirtualNetwork -Name hub-vnet

New-AzPrivateDnsVirtualNetworkLink -Name 'AKS-Peering' -ZoneName $DNSZone -VirtualNetworkId $targetvnet.Id -ResourceGroupName $DNSZoneRG -EnableRegistration
