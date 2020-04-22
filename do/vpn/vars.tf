variable "droplet_image" {
  description = "the image name of the droplet"
}

variable "droplet_name" {
  description = "the name of the droplet"
}

variable "droplet_size" {
  description = "the size of the droplet"
}

variable "droplet_ssh_key" {
  description = "name of ssh key to add to droplet"
}

variable "firewall_ssh_source_addresses" {
  description = "list of addresses to allow ssh connections from"
  type = list(string)
}

variable "openvpn_ca_path" {
  description = "absolute path to openvpn ca"
}

variable "openvpn_server_cert_path" {
  description = "absolute path to openvpn server cert"
}

variable "openvpn_server_key_path" {
  description = "absolute path to openvpn server key"
}

variable "openvpn_dh_path" {
  description = "absolute path to openvpn dh"
}

variable "openvpn_tls_auth_key_path" {
  description = "absolute path to openvpn tls aith key"
}

variable "region" {}

variable "tags" {
  description = "tags that will be added to the droplet and firewall, firewall rules are applied to droplets with same tags"
  type = list(string)
}
