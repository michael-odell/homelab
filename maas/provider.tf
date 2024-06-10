terraform {
  required_providers {
    maas = {
      source  = "maas/maas"
      #version = "~>2.2.0"
    }
  }
}

variable "MAAS_API_KEY" {
  type = string
}

provider "maas" {
  api_version = "2.0"
  api_url = "http://192.168.243.5:5240/MAAS"
  api_key = var.MAAS_API_KEY
}
