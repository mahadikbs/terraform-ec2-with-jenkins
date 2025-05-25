#!/bin/bash

sudo useradd --no-create-home --shell /bin/false prometheus

sudo useradd --no-create-home --shell /bin/false exporter

sudo mkdir /etc/prometheus /var/lib/prometheus

sudo chown prometheus:prometheus /etc/prometheus

sudo chown prometheus:prometheus /var/lib/prometheus

sudo mkdir /prometheus && cd /prometheus

curl -LO https://github.com/prometheus/prometheus/releases/download/v3.4.0/prometheus-3.4.0.linux-amd64.tar.gz

curl -LO https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz

tar -xvf prometheus-3.4.0.linux-amd64.tar.gz

tar -xvf node_exporter-1.3.1.linux-amd64.tar.gz

sudo cp -p ./prometheus-3.4.0.linux-amd64/prometheus /usr/local/bin

sudo cp -p ./prometheus-3.4.0.linux-amd64/promtool /usr/local/bin

sudo chown prometheus:prometheus /usr/local/bin/prom*

sudo cp -r ./prometheus-3.4.0.linux-amd64/consoles /etc/prometheus

sudo cp -r ./prometheus-3.4.0.linux-amd64/console_libraries /etc/prometheus

sudo chown -R prometheus:prometheus /etc/prometheus/consoles

sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries

sudo cp -p ./prometheus-3.4.0.linux-amd64/prometheus.yml /etc/prometheus

sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml

sudo cp -p ./node_exporter-1.3.1.linux-amd64/node_exporter /usr/local/bin

sudo chown exporter:exporter /usr/local/bin/node_exporter

# Configure Prometheus

sudo cp /etc/prometheus/prometheus.yml /etc/prometheus/prometheus.yml.backup



