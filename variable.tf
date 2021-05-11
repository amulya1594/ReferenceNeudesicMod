/* #variables for publicip
 variable "public_ip_variable" {
    type = map(object({
       name = string
       ip_version       = string
       allocation       = string
       sku              = string
       public_ip_dns    = string
       idle_timeout_in_minutes    = string
       zone = list(string)
        
    }))
}
 */
/* 
variable "create_resource_group"{
    description = "create rg"
    type = bool
    default = false
}
 */
variable "resource_group_name"{
    description = "name of rg"
    type = string
    default = "myrg"
}

variable "resource_group_location"{
    description = "location of rg"
    type = string
    default = "eastus2"
}
variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}



 variable "waf_variable" {
    type = map(object({
       waf_name= string
       wafenabled= string
       wafmode= string
       wafcheck= string
       filesize= string
       request_body_size= string
       managed_rule_set_type= string
       managed_rule_set_version= string

    }))
}

variable "managed_rules" {
    type = map(object({
       match_variable= string
       selector= string
       selector_match_operator= string
    }))
}  

variable "custom_rules" {
    type = map(object({
       name= string
       priority = string
       rule_type = string
       action = string
       operator           = string
       negation_condition = string
       match_values = list(string)
       variable_name = string
       
    }))
} 

/* 
variable "variable_name" {
  description = "name of the variable"
  type = list(string)
} */