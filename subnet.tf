resource "azurerm_subnet" "subnet" {
  for_each = try(var.subnet, {})

  name                                           = each.value.name
  resource_group_name                            = azurerm_resource_group.rg[each.value.resource_group_key].name
  virtual_network_name                           = azurerm_virtual_network.vnet[each.value.vnet_key].name
  address_prefixes                               = each.value.address_prefixes
  enforce_private_link_endpoint_network_policies = try(each.value.enforce_private_link_endpoint_network_policies, null)
  enforce_private_link_service_network_policies  = try(each.value.enforce_private_link_service_network_policies, null)
  service_endpoints                              = try(each.value.service_endpoints, null)
  service_endpoint_policy_ids                    = try(each.value.service_endpoint_policy_ids, null)

  dynamic "delegation" {
    for_each = try(each.value.delegation, null) == null ? [] : [1]

    content {
      name = each.value.delegation.name
      service_delegation {
        name    = each.value.delegation.service_delegation.name
        actions = lookup(each.value.delegation, "actions", null)
      }
    }
  }
}