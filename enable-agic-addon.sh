appgwId=$(az network application-gateway show -n AKS-AppGateway-WAF2 -g aks -o tsv --query "id")
echo $appgwId
az aks enable-addons -n aks -g aks -a ingress-appgw --appgw-id $appgwId
