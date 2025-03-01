#!/usr/bin/env python3
import os
import time
import requests
from yt_dlp import YoutubeDL
import concurrent.futures
from dotenv import load_dotenv

load_dotenv() # for running locally, reads env variables from .env file

API_URL = "https://www.googleapis.com/youtube/v3"

def get_channel_id(youtube_handle, api_key):
    url = f"{API_URL}/channels?part=id&forHandle={youtube_handle}&key={api_key}"
    response = requests.get(url)
    data = response.json()
    if 'items' in data and len(data['items']) > 0:
        return data['items'][0]['id']
    return None

def get_playlists(channel_id, api_key):
    playlists = []
    url = f"{API_URL}/playlists?part=snippet&channelId={channel_id}&maxResults=50&key={api_key}"
    response = requests.get(url)
    data = response.json()
    if 'items' in data:
        playlists = [item['id'] for item in data['items']]
    return playlists

def download_playlist(playlist_url):
    try:
        # Extract playlist info using a temporary configuration.
        temp_opts = {
            'quiet': True,
            'skip_download': True,
        }
        with YoutubeDL(temp_opts) as ydl:
            info = ydl.extract_info(playlist_url, download=False)
        playlist_title = info.get('playlist_title') or info.get('title') or 'default_playlist'
        
        # Create the folder for the playlist if it doesn't exist.
        folder = os.path.join('/data', playlist_title)
        if not os.path.exists(folder):
            os.makedirs(folder)
        
        # Update the options with the resolved playlist title.
        outtmpl = os.path.join('/data', playlist_title, '%(title)s.%(ext)s')
        download_archive = os.path.join('/data', playlist_title, 'downloaded.txt')
        ydl_opts = {
            'outtmpl': outtmpl,
            'download_archive': download_archive,
            'ignoreerrors': True,
            'quiet': False,
            'external_downloader': 'aria2c',
            'external_downloader_args': ['-x', '16', '-k', '1M'],
        }
        
        # Download the playlist using the updated options.
        with YoutubeDL(ydl_opts) as ydl:
            print(f"Downloading playlist: {playlist_title}")
            ydl.download([playlist_url])
    except Exception as e:
        print(f"Error processing {playlist_url}: {e}")

def main():
    # Read configuration from environment variables.
    youtube_handle = os.environ.get("YOUTUBE_HANDLE", "")
    api_key = os.environ.get("YOUTUBE_API_KEY", "")
    try:
        interval = int(os.environ.get("INTERVAL", "3600"))
    except ValueError:
        interval = 3600

    try:
        thread_count = int(os.environ.get("THREAD_COUNT", "5"))
    except ValueError:
        thread_count = 5

    if not youtube_handle or not api_key:
        print("Environment variables YOUTUBE_HANDLE and YOUTUBE_API_KEY must be set.")
        return

    channel_id = get_channel_id(youtube_handle, api_key)
    if not channel_id:
        print(f"Could not find channel for handle: {youtube_handle}")
        return

    while True:
        print(f"Fetching playlists for YouTube handle: {youtube_handle}")
        playlists = get_playlists(channel_id, api_key)
        if not playlists:
            print("No playlists found.")
        else:
            # Use the specified THREAD_COUNT, but don't create more threads than playlists.
            max_workers = min(thread_count, len(playlists))
            with concurrent.futures.ThreadPoolExecutor(max_workers=max_workers) as executor:
                future_to_playlist = {
                    executor.submit(download_playlist, f"https://www.youtube.com/playlist?list={playlist_id}"): playlist_id
                    for playlist_id in playlists
                }
                for future in concurrent.futures.as_completed(future_to_playlist):
                    playlist_id = future_to_playlist[future]
                    try:
                        future.result()
                    except Exception as exc:
                        print(f"Playlist {playlist_id} generated an exception: {exc}")
        print(f"Sleeping for {interval} seconds before next check...")
        time.sleep(interval)

if __name__ == "__main__":
    main()
