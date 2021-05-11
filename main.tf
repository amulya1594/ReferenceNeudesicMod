/* 
locals {
rg_name = var.create_resource_group ? azurerm_resource_group.rg[0].name : var.resource_group_name
rg_location = var.create_resource_group ? azurerm_resource_group.rg[0].location : var.resource_group_location
}

resource "azurerm_resource_group" "rg" {
  count = var.create_resource_group ? 1 : 0
  name = var.resource_group_name
  location = var.resource_group_location
  tags = var.tags
}
 */

data "azurerm_resource_group" "rg_search" {
  count = local.resourcegroup_state_exists == false ? 1 : 0
  name = var.resource_group_name
  //location = var.resource_group_location
}

locals {
  resourcegroup_state_exists = false
  /* 
  managed_rules = [{
    match_variable          = "RequestHeaderNames"
    selector                = "x-company-secret-header"
    selector_match_operator = "Equals"
  },
  {
    match_variable          = "RequestCookieNames"
    selector                = "too-tasty"
    selector_match_operator = "EndsWith"
  }]
   */
}

/* 
 resource "azurerm_public_ip" "public_ip" {
    //resource_group_name = local.rg_name
    //location = local.rg_location

    resource_group_name = local.resourcegroup_state_exists == true ? var.resource_group_name : data.azurerm_resource_group.rg_search.0.name
    location = local.resourcegroup_state_exists == true ? var.resource_group_location : data.azurerm_resource_group.rg_search.0.location

    for_each = var.public_ip_variable
    name = each.value["name"]
    ip_version          = each.value["ip_version"]
    allocation_method = each.value["allocation"]
    sku                 = each.value["sku"]
    domain_name_label   = each.value["public_ip_dns"]
    idle_timeout_in_minutes  = each.value["idle_timeout_in_minutes"]
    zones               =  each.value["zone"]
    tags = var.tags
} 

 */

 resource "azurerm_web_application_firewall_policy" "example" {

    
    resource_group_name = local.resourcegroup_state_exists == true ? var.resource_group_name : data.azurerm_resource_group.rg_search.0.name
    location = local.resourcegroup_state_exists == true ? var.resource_group_location : data.azurerm_resource_group.rg_search.0.location

    for_each = var.waf_variable
    name                = each.value["waf_name"]

 
   dynamic custom_rules {
     for_each = var.custom_rules
     content {
       name                    = custom_rules.value["name"]
       priority                = custom_rules.value["priority"]
       rule_type               = custom_rules.value["rule_type"]
       action                  = custom_rules.value["action"]
         match_conditions {
            match_variables {
              variable_name = custom_rules.value["variable_name"]
            }
            operator           =  custom_rules.value["operator"]
            negation_condition =  custom_rules.value["negation_condition"]
            match_values       =  custom_rules.value["match_values"]
         }
         
      } 
   }
   
  

  #policy setting
    policy_settings {   
    enabled                     = each.value["wafenabled"]  
    mode                        = each.value["wafmode"]   
    request_body_check          = each.value["wafcheck"]    
    file_upload_limit_in_mb     = each.value["filesize"]   
    max_request_body_size_in_kb = each.value["request_body_size"]
    }

    managed_rules {

      /*  #using local
       dynamic exclusion {
         for_each = local.managed_rules
         content {
           match_variable          = exclusion.value.match_variable
           selector                = exclusion.value.selector
           selector_match_operator = exclusion.value.selector_match_operator
         }
       }
      */

       #using terraform var file
       dynamic exclusion {
         for_each = var.managed_rules
         content {
           match_variable          = exclusion.value["match_variable"]
           selector                = exclusion.value["selector"]
           selector_match_operator = exclusion.value["selector_match_operator"]
         }
       }

       

    managed_rule_set {
      type    = each.value["managed_rule_set_type"]
      version = each.value["managed_rule_set_version"]

    }
    }

}

 