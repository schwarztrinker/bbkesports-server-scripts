resource "azurerm_resource_group" "main" {
  name     = "${local.global_prefix}-rg"
  location = "West Europe"
}
