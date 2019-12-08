# Install Postgresql

## Create Postgres Database
## Create Postgres Users
## Update Configs

# Install InfluxDB

    wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -
    source /etc/lsb-release
    echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
    apt-get update
    apt-get install influxdb
    service influxdb start

## Setup InfluxDB Database

    influx -precision rfc3339
    > create database mtgdata
