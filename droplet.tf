resource "digitalocean_droplet" "ghost" {
	image = "ubuntu-18-04-x64"
	name = "GhostBlog"
	region = "nyc1"
	size = "s-1vcpu-1gb"
	private_networking = true
	user_data = file("userdata.yaml")
	ssh_keys = [digitalocean_ssh_key.key.fingerprint]

    connection {
        type = "ssh"
        host = digitalocean_droplet.ghost.ipv4_address
        private_key = file("./server_keys/id_rsa")
        port = 22
        timeout = "5m"
        user = "root"
    }

	provisioner "file" {
        source = "${var.file_path}/docker-compose.yml"
        destination = "/home/docker-compose.yml"
    }

  provisioner "file" {
        source = "${var.file_path}/.env"
        destination = "/home/.env"
    }

    provisioner "remote-exec" {
      inline = [
        "cd /home",
        "mkdir ghost_home",
        "useradd ghost",
        "chown ghost:ghost ghost_home -R"
      ]
    }
}

output "ip" {
    value = digitalocean_droplet.ghost.ipv4_address
}
