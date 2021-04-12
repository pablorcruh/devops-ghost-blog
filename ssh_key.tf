resource "digitalocean_ssh_key" "key" {
	name = "key"
	public_key = file("./server_keys/id_rsa.pub")
}

