# CrowdSec Firewall Bouncer DaemonSet

This project deploys the CrowdSec Firewall Bouncer as a DaemonSet within a Kubernetes cluster. It's designed to dynamically apply IP-based blocking rules based on decisions from a CrowdSec instance, enhancing the security posture of your cluster's nodes.

## Prerequisites

1. Kubernetes cluster
2. kubectl configured to communicate with your cluster
3. Helm 3 installed
3. CrowdSec installed and configured (https://github.com/crowdsecurity/helm-charts/tree/main)

## Configuration

### API Keys

The DaemonSet requires API keys to interact with the CrowdSec service. You must provide these keys in a Kubernetes secret. The keys can be generated with the following command:

```bash
cscli bouncers add worker-1
```

An example `apikeys.yaml` for your Kubernetes Secret might look like:

```yaml
worker-1: <KEY>
worker-2: <KEY>
...
```
It is important, that the bouncer names match the hostnames of the nodes in your Kubernetes cluster. Each pod will look for the API key corresponding to its hostname in the secret.

## Installation

### Add Helm Repository
First, add the `crowdsec-firewall-bouncer-daemonset` Helm repository:

```bash
helm repo add crowdsec-firewall-bouncer-daemonset https://l3montree-dev.github.io/crowdsec-firewall-bouncer-daemonset
```

### Deploy with Helm
Use the `helm upgrade --install` command to deploy or update the CrowdSec Firewall Bouncer DaemonSet. You'll need to specify the `values.yaml` file that contains your configuration overrides:

```bash
helm upgrade --install -f values.yaml --namespace crowdsec crowdsec-firewall-bouncer crowdsec-firewall-bouncer-daemonset/crowdsec-firewall-bouncer-daemonset
```

Ensure you've created the `crowdsec` namespace beforehand or specify a different namespace that exists in your cluster.