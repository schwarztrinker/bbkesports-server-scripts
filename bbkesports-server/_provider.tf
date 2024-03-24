terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.95.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.26.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "f60af1ce-fd03-4168-9851-c69589e517f5"
}

provider "cloudflare" {
  api_token = local.envs["CLOUDFLARE_API_TOKEN"]
}