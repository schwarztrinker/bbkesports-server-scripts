terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.24.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.26.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "9ac3d5b0-5544-4d95-b89d-95cf6c1751e8"
}

provider "cloudflare" {
  api_token = local.envs["CLOUDFLARE_API_TOKEN"]
}
