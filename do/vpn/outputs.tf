output "droplet_ip_address" {
  value = digitalocean_droplet.vpn.ipv4_address
}
