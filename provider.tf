variable "do_token" {}
variable "file_path" {}
variable "domain" {}
provider "digitalocean" {
	token = var.do_token
}

terraform {
  required_providers {
    digitalocean = {
      # source is required for providers in other namespaces, to avoid ambiguity.
      source  = "digitalocean/digitalocean"
    }
  }
}

