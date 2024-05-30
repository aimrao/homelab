#!/bin/bash

# Define qBittorrent Web UI credentials
cookie=$(curl -i -s http://localhost:8081/api/v2/auth/login | grep -oP 'set-cookie:\s*\K[^;]*')
# I have disabled auth for localhost connections so no need to pass creds, however if you want to pass creds uncomment the below line to get cookie.
# cookie=$(curl -i -s --data 'username=admin&password=admin' http://localhost:8081/api/v2/auth/login | grep -oP 'set-cookie:\s*\K[^;]*')
qb_url="http://localhost:8081"
forwarded_port_file="/vpn/forwarded_port"

# Function to get the listen port from qBittorrent API
get_listen_port() {
    listen_port=$(curl -s "$qb_url/api/v2/app/preferences" --cookie $cookie | jq -r '.listen_port')
    echo "$listen_port"
}

# Function to get the forwarded port from the file
get_forwarded_port() {
    if [ -f "$forwarded_port_file" ]; then
        forwarded_port=$(cat "$forwarded_port_file")
        echo "$forwarded_port"
    else
        echo "File $forwarded_port_file not found."
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
