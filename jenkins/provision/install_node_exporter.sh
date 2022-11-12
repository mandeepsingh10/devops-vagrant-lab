
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

