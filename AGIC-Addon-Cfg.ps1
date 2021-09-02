
#-----------------------------------------------------------------------------------------------------------------
#                                              Enable & Configure AGIC. 
#-----------------------------------------------------------------------------------------------------------------
az login
#-----------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------
# Enable the AGIC add-on in existing AKS cluster with existing Application Gateway

# [1] Register the AKS-IngressApplicationGatewayAddon feature 
az extension add --name aks-preview
az feature register --name AKS-IngressApplicationGatewayAddon --namespace Microsoft.ContainerService

# --> Note : Might take few minutes to register the feature 
# Check the status using the following command 
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/AKS-IngressApplicationGatewayAddon')].{Name:name,State:properties.state}"
az provider register --namespace Microsoft.ContainerService 

appgwId=$(az network application-gateway show -n AKS-AppGateway-WAF2 -g aks -o tsv --query "id") 
az aks enable-addons -n aks -g aks -a ingress-appgw --appgw-id $appgwId



#-----------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------
# Deploy a sample application using AGIC

az aks get-credentials --name aks --resource-group aks

kubectl apply -f https://raw.githubusercontent.com/Azure/application-gateway-kubernetes-ingress/master/docs/examples/aspnetapp.yaml


# Check that the application is reachable
kubectl get ingress

#-----------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------

