global_settings = {

  base_tags = {
    task = "terraform test"
  }

  region = {
    region1 = "eastasia"
  }
}

resource_group = {
    rg1 = {
        name =  "tf-test-rg-01"
        location = "eastasia" //can i get the locaiton here as a variable instead? to avoid redundancy?
    }
}

vnet = {
    vnet1 = {
        name = "vnet-01"
        location = "eastasia"
        resource_group_key = "rg1"
        address_space = ["10.1.0.0/16"]
    }
}

subnet = {
    subnet1 = {
        name = "subnetname1"
        resource_group_key = "rg1"
        vnet_key = "vnet1"
        address_prefixes = ["10.1.1.0/24"] //this gives 256 IP addresses

        service_endpoints = ["Microsoft.Storage"]
        
        delegation = {
            name = "delegation1"
            service_delegation = {
                name = "Microsoft.DBforPostgreSQL/flexibleServers"
                actions = [
                    "Microsoft.Network/virtualNetworks/subnets/join/action",
                ]
            }
        }
    }
}

nsg = {
    nsg1 = {
        name = "nsgname1"
        location = "eastasia"
        resource_group_key = "rg1"

        security_rule = {
            content = {
                name = "test1"
                priority = 100
                direction = "Inbound"
                access = "Allow"
                protocol = "Tcp"
                source_port_range = "*"
                destination_port_range = "*"
                source_address_prefix = "*"
                destination_address_prefix = "*"
 
            }
        }
    }
}

nsg_subnet_association = {
    subnet_key = "subnet1"
    nsg_key = "nsg1"
}



