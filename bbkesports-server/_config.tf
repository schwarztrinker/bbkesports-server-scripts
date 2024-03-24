locals {
  # Load .env file
  envs = { for tuple in regexall("(.*)=(.*)", file(".env")) : tuple[0] => tuple[1] }

  global_prefix = "mst-bbkesports"
}

data "azurerm_client_config" "current" {}