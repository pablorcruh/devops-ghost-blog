resource "digitalocean_domain" "ghost" {
  name = var.domain
}

resource "digitalocean_record" "www" {
  domain = digitalocean_domain.ghost.name
  name = "ghost"
  type = "A"
  value = digitalocean_droplet.ghost.ipv4_address
}
