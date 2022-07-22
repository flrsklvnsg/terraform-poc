
resource "azurerm_network_security_group" "nsg" {
  for_each = try(var.nsg, {})

  name                = each.value.name
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rg[each.value.resource_group_key].name

  dynamic "security_rule" {
    for_each = try(each.value.security_rule, [])

    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

  tags = merge(try(var.global_settings.base_tags, null), try(each.value.tags, null))
}


resource "azurerm_subnet_network_security_group_association" "nsg_subnet_association" {
  for_each = try(var.nsg_subnet_association, null)

  subnet_id                 = azurerm_subnet.subnet[each.value.subnet_key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.value.nsg_key].id

}