resource "azurerm_virtual_network" "vnet" {
  for_each = try(var.vnet, {})

  name                = each.value.name
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rg[each.value.resource_group_key].name
  address_space       = each.value.address_space
  tags                = merge(try(var.global_settings.base_tags, null), try(each.value.tags, null))

}

output "address_space" {
  value = { for key, value in azurerm_virtual_network.vnet : key => value.address_space }
}

