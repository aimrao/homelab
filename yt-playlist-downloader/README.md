# YouTube Playlist Downloader

This project downloads videos from all playlists of a given YouTube channel (specified by its handle) using the YouTube Data API, yt-dlp (with aria2 and ffmpeg), and concurrent processing. Downloaded files are stored under `/data`.

---

## Prerequisites

### For Local Setup

- **YouTube Data API v3 Key:**  
  Obtain one from the [Google Developer Console](https://console.developers.google.com/).
- **Python 3.9+**  
- **Dependencies:**  
  - [yt-dlp](https://github.com/yt-dlp/yt-dlp)
  - [aria2](https://aria2.github.io/)
  - [ffmpeg](https://ffmpeg.org/download.html)
  - [requests](https://docs.python-requests.org/)
  - [python-dotenv](https://pypi.org/project/python-dotenv/) *(optional, for loading environment variables from a `.env` file)*

### For Docker Setup

- **Docker & Docker Compose**

---

## Required Environment Variables

The application requires the following environment variables:

- **YOUTUBE_HANDLE**  
  The YouTube channel handle (e.g., `SomeChannelHandle`).

- **YOUTUBE_API_KEY**  
  Your YouTube Data API v3 key.

- **INTERVAL**  
  Time interval (in seconds) between checks for new videos.  
  _Default: 3600_

- **THREAD_COUNT**  
  Number of concurrent threads to process playlists.  
  _Default: 5_

---

## Running with Docker

### Using Docker Compose

1. **Create or Update the `docker-compose.yml` File**

   Use the following content:

   ```yaml
   version: "3"
   services:
     yt-playlist-downloader:
       image: 4imrao/yt-playlist-downloader
       container_name: yt-playlist-downloader
       volumes:
         - /tank/data/media/yt:/data
       environment:
         - YOUTUBE_HANDLE=[REDACTED]
         - YOUTUBE_API_KEY=[REDACTED]
         - INTERVAL=86400
         - THREAD_COUNT=5
       logging:
         driver: "json-file"
         options:
           max-size: "10m"
           max-file: "3"
       restart: unless-stopped
    ```

    Replace `[REDACTED]` with your actual YouTube channel handle and API key. Adjust other environment variables as needed.

2. **Deploy the Container**

    Open a terminal and run:

    ```bash
    docker-compose up -d
    ```

    This command pulls the image (if not already available), creates the container, and starts it in detached mode. The host directory `/tank/data/media/yt` is mounted to the container's `/data` directory to persist downloads.

3. **Verify the Container is Running**

    Check the running containers with:

    ```bash
    docker ps
    ```

4. **Monitor Logs**

    To view the container logs, use:

    ```bash
    docker logs -f yt-playlist-downloader
    ```

5. **Stopping the Container**

    To stop the container, run:

    ```bash
    docker-compose down
    ```

    Alternatively, you can stop the container directly with:

    ```bash
    docker stop yt-playlist-downloader
    ```

## Running Locally

### Setup Steps

1. **Clone the Repository**

    ```bash
    git clone <repository_url>
    cd <repository_directory>
    ```

2. **Install Python Dependencies**

    ```bash
    pip install -r requirements.txt
    ```

3. **Install aria2 and ffmpeg**

    - On Windows:
        Download and install [aria2](https://aria2.github.io/) and [ffmpeg](https://ffmpeg.org/download.html). Ensure both are added to your system's PATH.

    - On Linux (Debian/Ubuntu):

        ```bash
        sudo apt-get update
        sudo apt-get install aria2 ffmpeg
        ```

    - On macOS (using Homebrew):

        ```bash
        brew install aria2 ffmpeg
        ```

4. **Set Environment Variables**

    You can either export them in your shell or create a `.env` file in the project directory. For example, create a `.env` file with:

    ```dotenv
    YOUTUBE_HANDLE=YOUR_YOUTUBE_HANDLE
    YOUTUBE_API_KEY=YOUR_YOUTUBE_API_KEY
    INTERVAL=3600
    THREAD_COUNT=5
    ```

5. **Run the Script**

    ```bash
    python main.py
    ```

**Note:** If you use a `.env` file, the script will automatically load the environment variables if you have included `from dotenv import load_dotenv; load_dotenv()` at the top.