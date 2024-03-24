data "cloudflare_zone" "main" {
  name = "mstoecker.de"
}

resource "cloudflare_record" "main" {
  zone_id = data.cloudflare_zone.main.id
  name    = "bbke"
  value   = azurerm_linux_virtual_machine.main.public_ip_address
  type    = "A"
  ttl     = 60
}