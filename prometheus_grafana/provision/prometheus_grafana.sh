#!/usr/bin/env bash
sudo apt-get update

#create a system user or system account
sudo useradd \
    --system \
    --no-create-home \
    --shell /bin/false prometheus

# download prometheus installation files
wget https://github.com/prometheus/prometheus/releases/download/v2.37.2/prometheus-2.37.2.linux-amd64.tar.gz

# Extract files
tar -xvzf prometheus-2.37.2.linux-amd64.tar.gz

#create a folder for prometheus data and configuration files
sudo mkdir -p /data /etc/prometheus
cd prometheus-2.37.2.linux-amd64

#move the prometheus binary and a promtool to the /usr/local/bin/
sudo mv prometheus promtool /usr/local/bin/

#move console libraries to the Prometheus configuration directory
sudo mv consoles/ console_libraries/ /etc/prometheus/

#move the example of the main prometheus configuration file
sudo mv prometheus.yml /etc/prometheus/prometheus.yml

#set correct ownership for the /etc/prometheus/ and data directory.
sudo chown -R prometheus:prometheus /etc/prometheus/ /data/

#delete the archive and prometheus folder
cd
rm -rf prometheus*


#create a systemd unit configuration file
cd /etc/systemd/system/
cat <<EOT > /etc/systemd/system/prometheus.service

[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=prometheus
Group=prometheus
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/data \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.enable-lifecycle

[Install]
WantedBy=multi-user.target


EOT

##Reload systemctl daemon
systemctl daemon-reload

## Start and enable prometheus service
sudo systemctl start prometheus
sudo systemctl enable prometheus


#install Node Exporter

#create a system user for Node Exporter 
sudo useradd \
    --system \
    --no-create-home \
    --shell /bin/false node_exporter

#download Node Exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.4.0/node_exporter-1.4.0.linux-amd64.tar.gz

#extract node exporter
tar -xvf node_exporter-1.4.0.linux-amd64.tar.gz

#move the binary to /usr/local/bin
sudo mv \
  node_exporter-1.4.0.linux-amd64/node_exporter \
  /usr/local/bin/

#Clean up, delete node_exporter archive and a folder.
rm -rf node_exporter*

node_exporter --version

#create a systemd unit configuration file
cd /etc/systemd/system/
cat <<EOT > /etc/systemd/system/node_exporter.service

[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=node_exporter
Group=node_exporter
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/node_exporter \
    --collector.logind

[Install]
WantedBy=multi-user.target

EOT

##Reload systemctl daemon
systemctl daemon-reload

## Start and enable node_exporter service
sudo systemctl start node_exporter
sudo systemctl enable node_exporter

##configure prometheus.yml

cd /etc/prometheus/
cat <<EOT > prometheus.yml

global:
  scrape_interval:     15s # By default, scrape targets every 15 seconds.

  # Attach these labels to any time series or alerts when communicating with
  # external systems (federation, remote storage, Alertmanager).
  external_labels:
    monitor: 'codelab-monitor'

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label job=<job_name> to any timeseries scraped from this config.
  - job_name: 'node-prometheus'

    static_configs:
      - targets: ['localhost:9100']

EOT

#System has been provisioned
