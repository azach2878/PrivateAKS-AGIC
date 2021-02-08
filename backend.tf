
 /* Uncomment if you want to use Azure Storage account as a backend for your TFSTATE Files
 terraform {
  backend "azurerm" {
    resource_group_name     = "Enter the Resource Group Name here"
    storage_account_name    = "Enter Storage account name here"
    container_name          = "Contriner name"
    key                     = "AKS/terraform.tfstate"
  }
}
*/
