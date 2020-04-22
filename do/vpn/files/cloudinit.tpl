#cloud-config
packages:
  - iptables
  - openvpn
write_files:
  - encoding: b64
    content: ${openvpn_server_config}
    owner: root:root
    path: /etc/openvpn/server/server.conf
    permissions: '0600'
  - encoding: b64
    content: ${openvpn_ca}
    owner: root:root
    path: /etc/openvpn/server/ca.pem
    permissions: '0600'
  - encoding: b64
    content: ${openvpn_server_cert}
    owner: root:root
    path: /etc/openvpn/server/server.pem
    permissions: '0600'
  - encoding: b64
    content: ${openvpn_server_key}
    owner: root:root
    path: /etc/openvpn/server/server-key.pem
    permissions: '0600'
  - encoding: b64
    content: ${openvpn_dh}
    owner: root:root
    path: /etc/openvpn/server/dh2048.pem
    permissions: '0600'
  - encoding: b64
    content: ${openvpn_tls_auth_key}
    owner: root:root
    path: /etc/openvpn/server/ta.key
    permissions: '0600'
  - encoding: b64
    content: ${openvpn_client1_config}
    owner: root:root
    path: /etc/openvpn/ccd/client1
    permissions: '0600'
  - encoding: b64
    content: ${openvpn_iptables}
    owner: root:root
    path: /usr/local/bin/openvpn-iptables.sh
    permissions: '0755'
  - encoding: b64
    content: ${openvpn_iptables_service}
    owner: root:root
    path: /etc/systemd/system/openvpn-iptables.service
    permissions: '0644'
runcmd:
  - "echo 'net.ipv4.conf.all.forwarding = 1' > /usr/lib/sysctl.d/90-ipv4-forwarding.conf"
  - [sysctl, --load, /usr/lib/sysctl.d/90-ipv4-forwarding.conf]
  - [systemctl, daemon-reload]
  - [systemctl, --no-block, enable, openvpn-iptables.service]
  - [systemctl, --no-block, start, openvpn-iptables.service]
  - [systemctl, --no-block, enable, openvpn-server@server.service]
  - [systemctl, --no-block, start, openvpn-server@server.service]
