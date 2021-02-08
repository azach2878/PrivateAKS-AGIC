#########################################################################################
#                               Deplyment Variables 
#########################################################################################

variable "rgname" {
  description   = "aks resource group."
  default       =  "aks"
}
#########################################################################################
variable "location" {
  description   = "Location of the cluster."
  default       = "East US 2"
}
#########################################################################################
variable "tags" {
  default = {
    Environment = "DEV"
    CostCenter  = "IT Department"
    Team        = "Infrastructure Team"
    Owener      = "Adam Zachary"
  }
}
#########################################################################################
variable "virtual_network_name" {
  description = "Virtual network name"
  default     = "AKS_vNet"
}
#########################################################################################
#                                  AKS Variables
#########################################################################################
variable "aks_cluster_name" {
    description = "The name of the AKS cluster resource."
    default     = "aks"
}

variable "dns_prefix" {
    default     = "aks"
}

variable "vm_user_name" {
  description   = "User name for the VM"
  default       = "vmuser1"
}
#########################################################################################
#                                    ACR 
#########################################################################################

variable "container_registry_name" {
    default =  "adamacrpoc1"
}

#########################################################################################
#                                   Hub Resources 
#########################################################################################

variable "oms_location" {
  default = "East US 2"
}

variable "oms_rg" {
  default =  "sharedservices"
}

variable "oms_name" {
  default = "oms-123abc"
}

variable "hub_vnet_location" {
  default = "East US 2" 
}
variable "hub_rg" {
  default = "Hub-Network"
}

variable "hub_vnet" {
  default = "Hub-vNet" 
}

variable "fw_name" {
  default = "Firewall"
}

variable "fw_rg" {
  default = "Hub-Network"
}

variable "acr_name" {
  default =  "enter your ACR Name here"
}
variable "acr_rg" {
  default = "enter your acr rg name here"
}
