provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  //version = "=2.46.0"
 
 subscription_id  = "0e2b673d-7c5e-4130-99a5-505146ab8ac1"
 client_id        = "990d3c7f-ee2e-4d33-aa71-72f15558b784"
 client_secret    = "ruIpNGrItm6HAY.83.3F2Ev._fp9fUb1r2"
 tenant_id        = "317410c9-979d-401c-a3cc-5bf68d88561d"

  features {}
}

module waf {
    source = "./modules"
    //create_resource_group                      = var.create_resource_group
    resource_group_name                        = var.resource_group_name
    resource_group_location                    = var.resource_group_location
    tags                                       = var.tags
   // public_ip_variable = var.public_ip_variable
    waf_variable = var.waf_variable

    managed_rules = var.managed_rules

    custom_rules = var.custom_rules

    //match_conditions = var.match_conditions

    //match_variables = var.match_variables
 
    //variable_name = var.variable_name

} 