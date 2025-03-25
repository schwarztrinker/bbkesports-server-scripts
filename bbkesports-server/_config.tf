locals {
  # Load .env file
  envs = { for tuple in regexall("(.*)=(.*)", file(".env")) : tuple[0] => tuple[1] }

  global_prefix = "mst-bbkesports"

  me_obj_id = data.azurerm_client_config.current.object_id

  vm_size = "Standard_B4s_v2"
}

data "azurerm_client_config" "current" {}

