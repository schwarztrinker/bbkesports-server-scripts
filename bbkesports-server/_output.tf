output "vm_password" {
  value = azurerm_key_vault_secret.vm_password.value
  sensitive = true
}
