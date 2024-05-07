#!/bin/bash

# Define qBittorrent Web UI credentials
cookie=""
qb_url="http://localhost:8081"

# Function to get the listen port from qBittorrent API
get_listen_port() {
    listen_port=$(curl "$qb_url/api/v2/app/preferences" --cookie $cookie | jq -r '.listen_port')
    echo "$listen_port"
}

# Function to get the forwarded port from the file
get_forwarded_port() {
    if [ -f "/tmp/gluetun/forwarded_port" ]; then
        forwarded_port=$(cat "/tmp/gluetun/forwarded_port")
        echo "$forwarded_port"
    else
        echo "File /tmp/gluetun/forwarded_port not found."
        exit 1
    fi
}

# Function to update the forwarded port in qBittorrent via API
update_forwarded_port() {
    curl -X POST "$qb_url/api/v2/app/setPreferences" --cookie $cookie -d 'json={"listen_port":"'"$1"'"}'
}

# Main script logic
listen_port=$(get_listen_port)
forwarded_port=$(get_forwarded_port)

if [ "$forwarded_port" != "$listen_port" ]; then
    update_forwarded_port "$forwarded_port"
    echo "Updated listen port in qBittorrent to $forwarded_port"
else
    echo "Listen port in qBittorrent is already up to date."
fi
