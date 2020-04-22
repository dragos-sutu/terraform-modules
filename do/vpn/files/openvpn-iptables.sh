#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

iptables --insert FORWARD --in-interface tun0 --out-interface eth0 --source 10.8.0.0/24 --match conntrack --ctstate NEW --jump ACCEPT

iptables --insert FORWARD --match conntrack --ctstate RELATED,ESTABLISHED --jump ACCEPT

iptables --table nat --insert POSTROUTING --out-interface eth0 --source 10.8.0.0/24 --jump MASQUERADE
