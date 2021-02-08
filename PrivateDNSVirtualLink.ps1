You need to create a new Virtual Network Link in your Private DNS.
$DNSZone        = "Your AKS Private DNS Zone Name"
$DNSZoneRG      = "mc_ aks RG"
$TargetvNet     = Get-AzVirtualNetwork -Name hub-vnet

New-AzPrivateDnsVirtualNetworkLink -Name 'AKS-Peering' -ZoneName $DNSZone -VirtualNetworkId $targetvnet.Id -ResourceGroupName $DNSZoneRG -EnableRegistration