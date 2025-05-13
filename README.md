# Homelab Configurations

Welcome to the Homelab Configurations repository! This project holds all the configuration files and scripts for various homelab applications. Each folder is tailored for a specific service with its required Docker Compose files, environment configurations, and supporting scripts to help you deploy, manage, and monitor your homelab services.

## Table of Contents

- [Overview](#overview)
- [Repository Structure and Details](#repository-structure-and-details)
  - [arr-stack](#arr-stack)
  - [code-server](#code-server)
  - [duplicati](#duplicati)
  - [filebrowser](#filebrowser)
  - [homarr](#homarr)
  - [jellyfin](#jellyfin)
  - [monitoring](#monitoring)
  - [nextcloud](#nextcloud)
  - [npm](#npm)
  - [photoprism](#photoprism)
  - [portainer](#portainer)
  - [scripts](#scripts)
  - [watchtower](#watchtower)
  - [yt-playlist-downloader](#yt-playlist-downloader)
- [License](#license)
- [Contact](#contact)

## Overview

This repository contains the configuration files and scripts needed to deploy and maintain various homelab applications. Each directory is dedicated to one service or tool and contains the necessary Docker Compose files, environment configuration files, and custom scripts to streamline your setup.

## Repository Structure and Details

Below is a detailed explanation of each directory based on its content:

### arr-stack
- **Files:**  
  - A `docker-compose.yml` file to deploy multiple media automation tools (typically Sonarr, Radarr, Lidarr, etc.) as part of the ARR stack.
  - Environment files to define paths, API keys, and other parameters specific to each container.
- **Purpose:**  
  Automates the process of downloading and organizing media by integrating several ARR-based applications into a single, manageable service.

### code-server
- **Files:**  
  - A `docker-compose.yml` file for setting up Codeserver.
- **Purpose:**  
  VSCode in browser.

### duplicati
- **Files:**  
  - A `docker-compose.yml` file for running the Duplicati backup container.
  - Configuration files that set backup schedules, retention policies, and define storage locations.
- **Purpose:**  
  Provides an automated backup solution to ensure your data is safely stored and easily recoverable.

### filebrowser
- **Files:**  
  - A `docker-compose.yml` file for setting up Filebrowser.
- **Purpose:**  
  UI for accessing files across server.

### homarr
- **Files:**  
  - Configuration files (e.g., JSON or YAML) for setting up the Homarr dashboard.
  - Possibly a Docker Compose file that deploys the Homarr container.
- **Purpose:**  
  Offers a customizable dashboard to monitor and control your homelab services from one central interface.

### jellyfin
- **Files:**  
  - A `docker-compose.yml` file to deploy Jellyfin.
  - Configuration files to set up media libraries, transcode settings, and metadata paths.
- **Purpose:**  
  Serves as your personal media server, managing and streaming your media content efficiently.

### monitoring
- **Files:**  
  - Docker Compose configurations for monitoring tools (e.g., Prometheus, Grafana).
  - YAML configuration files for setting up dashboards, alerts, and custom metrics.
- **Purpose:**  
  Enables real-time monitoring of system performance, resource usage, and logs to ensure all services are running smoothly.

### nextcloud
- **Files:**  
  - A `docker-compose.yml` file for deploying Nextcloud.
  - Environment files (e.g., `.env`) that define storage paths, database connections, and network settings.
- **Purpose:**  
  Provides a private cloud storage solution to sync and share files securely across devices.

### npm
- **Files:**  
  - A `docker-compose.yml` file for running Nginx Proxy Manager.
  - SSL configuration files and environment variables for managing secure reverse proxy setups.
- **Purpose:**  
  Manages incoming web traffic and routes requests to the appropriate backend services while handling SSL termination.

### photoprism
- **Files:**  
  - A `docker-compose.yml` file that configures Photoprism.
  - Environment configuration files to set up volume mappings for photo storage, database settings, and other options.
- **Purpose:**  
  Provides an application for organizing, indexing, and browsing your photo collection.

### portainer
- **Files:**  
  - A `docker-compose.yml` file for setting up Portainer.
- **Purpose:**  
  For deploying and maintaining different app stacks in Docker.

### scripts
- **Files:**  
  - A collection of shell scripts (e.g., `backup.sh`, `update.sh`) designed for routine maintenance tasks.
  - Custom automation scripts to handle updates, cleanups, and other administrative actions.
- **Purpose:**  
  Automates recurring tasks to simplify maintenance and enhance the efficiency of your homelab operations.

### watchtower
- **Files:**  
  - A `docker-compose.yml` file for setting up Watchtower.
  - Configuration details to define intervals and rules for monitoring Docker container updates.
- **Purpose:**  
  Automatically checks for updates to Docker images and restarts containers with the new versions, ensuring your services remain up-to-date.

### yt-playlist-downloader
- **Files:**  
  - Source code in python.
  - Dockerfile to create the docker image.
  - A `docker-compose.yml` file for deploying the container.
- **Purpose:**  
  Automatically checks for new video added in a playlist for a particular channel and downloads it, read app-specific README for more info.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

If you wish to reach out, you can consider opening an issue in the repository or forking the repository and initiating a pull request with your queries.
