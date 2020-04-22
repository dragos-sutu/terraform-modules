resource "digitalocean_ssh_key" "key" {
  name       = "key"
  public_key = file(var.public_key_file_path)
}
