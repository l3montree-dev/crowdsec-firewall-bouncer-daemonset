#!/bin/bash

# Check if IP sets exist, and create them if not
if ! sudo ipset list | grep -q "blacklists_ipv4"; then
    sudo ipset create blacklists_ipv4 hash:ip timeout 0 maxelem 150000
fi

if ! sudo ipset list | grep -q "blacklists_ipv6"; then
    sudo ipset create blacklists_ipv6 hash:ip timeout 0 family inet6 maxelem 150000
fi

# Check if iptables rules exist, and add them if not
if ! sudo iptables -C INPUT -m set --match-set blacklists_ipv4 src -j DROP &>/dev/null; then
    sudo iptables -I INPUT 1 -m set --match-set blacklists_ipv4 src -j DROP
fi

if ! sudo ip6tables -C INPUT -m set --match-set blacklists_ipv6 src -j DROP &>/dev/null; then
    sudo ip6tables -I INPUT 1 -m set --match-set blacklists_ipv6 src -j DROP
fi
