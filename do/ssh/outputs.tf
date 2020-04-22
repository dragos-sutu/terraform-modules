output "ssh_key_id" {
  value = digitalocean_ssh_key.vpn.id
}

output "ssh_key_fingerprint" {
  value = digitalocean_ssh_key.vpn.fingerprint
}
