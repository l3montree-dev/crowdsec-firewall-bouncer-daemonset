FROM bitnami/minideb:bookworm

RUN apt-get update && apt-get install -y curl

COPY install_apt-repository.sh install_apt-repository.sh
RUN ./install_apt-repository.sh

RUN apt-get update && apt-get install -y crowdsec-firewall-bouncer-iptables

RUN apt-get clean && apt-get autoremove

COPY install_ipsets.sh install_ipsets.sh
COPY install_firewall_bouncer.sh install_firewall_bouncer.sh