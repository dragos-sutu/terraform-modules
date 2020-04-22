data "digitalocean_ssh_key" "ssh_key" {
  name = var.droplet_ssh_key
}

data "template_file" "cloudinit" {
  template = file("${path.module}/files/cloudinit.tpl")

  vars = {
    openvpn_server_config = filebase64("${path.module}/files/openvpn-server.conf")
    openvpn_client1_config = filebase64("${path.module}/files/openvpn-client1.conf")
    openvpn_iptables = filebase64("${path.module}/files/openvpn-iptables.sh")
    openvpn_iptables_service = filebase64("${path.module}/files/openvpn-iptables.service")

    openvpn_ca = filebase64(var.openvpn_ca_path)
    openvpn_server_cert = filebase64(var.openvpn_server_cert_path)
    openvpn_server_key = filebase64(var.openvpn_server_key_path)
    openvpn_dh = filebase64(var.openvpn_dh_path)
    openvpn_tls_auth_key = filebase64(var.openvpn_tls_auth_key_path)
  }
}

data "template_cloudinit_config" "cloudinit" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content      = data.template_file.cloudinit.rendered
  }
}

resource "digitalocean_droplet" "vpn" {
  image     = var.droplet_image
  ipv6      = true
  name      = var.droplet_name
  region    = var.region
  size      = var.droplet_size
  ssh_keys  = [
    data.digitalocean_ssh_key.ssh_key.id
  ]
  tags      = var.tags
  user_data = data.template_cloudinit_config.cloudinit.rendered
}
