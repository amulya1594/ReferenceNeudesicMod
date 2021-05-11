  //create_resource_group                      = true
  resource_group_name                        = "waf"
  resource_group_location                    = "EastUS"

  tags = {
    environment = "dev"
    created_by  = "amulya"
  }

/* 
#PUBLIC IP
  public_ip_variable = {
  "public_ip_variable1" = {
    name    = "qewyubgcxcvbgfd"
    ip_version       = "IPv4"
    allocation       = "Static"
    sku              = "Standard"
    public_ip_dns    = "qewyubgcxcvbgfd"
    idle_timeout_in_minutes     = "30"
    zone             = ["1"]
},
   "public_ip_variable2" = {
    name    = "pomjdebgsfsdf"
    ip_version       = "IPv4"
    allocation       = "Static"
    sku              = "Standard"
    public_ip_dns    = "pomjdebgsfsdf"
    idle_timeout_in_minutes     = "30"
    zone             = ["1"]
 }
}

 */


#WAF

  waf_variable = {
  "waf_variable1" = {
    waf_name= "wafpolicy"
    wafenabled= "true"
    wafmode= "Prevention"
    wafcheck= "true"
    filesize= "100"
    request_body_size= "128"
    managed_rule_set_type= "OWASP"
    managed_rule_set_version= "3.1"
  },

   "waf_variable2" = {
    waf_name= "wafpolicy"
    wafenabled= "true"
    wafmode= "Detection"
    wafcheck= "true"
    filesize= "100"
    request_body_size= "128"
    managed_rule_set_type= "OWASP"
    managed_rule_set_version= "3.1"
     
   }
}

#managed_rules
managed_rules = {
  "managed_rule1" = {
    match_variable          = "RequestHeaderNames"
    selector                = "x-company-secret-header"
    selector_match_operator = "Equals"
  },
  "managed_rule2" = {
    match_variable          = "RequestCookieNames"
    selector                = "too-tasty"
    selector_match_operator = "EndsWith"
  }
}  

#custom_rules
custom_rules = {
  "custom_rule1" = {
       name= "Rule1"
       priority = "1"
       rule_type = "MatchRule"
       action = "Block" 
       operator = "IPMatch"
       negation_condition = "false"
       match_values = ["192.168.1.0/24", "10.0.0.0/24"]  
       variable_name = "RemoteAddr"    
  },
  "custom_rule2" = {
     name= "Rule2"
     priority = "2"
     rule_type = "MatchRule"
     action = "Block"  
     operator           = "Contains"  
     negation_condition = "false"
     match_values = ["Windows"]   
     variable_name = "RequestHeaders"
  }
} 
/*  
match_variables = {
  "match_variable1" = {
       variable_name = "RemoteAddr"
  }
} 
  
match_conditions = {
  "match_condition1" = {
       operator = "IPMatch"
       negation_condition = "false"
       match_values = ["192.168.1.0/24"]
  }
}         */

//variable_name = ["RemoteAddr"]