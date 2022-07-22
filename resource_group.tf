
resource "azurerm_resource_group" "rg" {
  for_each = var.resource_group

  name     = each.value.name
  location = each.value.location
  tags     = merge(try(var.global_settings.base_tags, null), try(each.value.tags, null))

}

output "id" {
  value = { for key, value in azurerm_resource_group.rg : key => value.id }
}


  
