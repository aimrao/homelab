FROM python:3.9-slim

# Install aria2 and required Python libraries.
RUN apt-get update && apt-get install -y aria2 ffmpeg && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY main.py requirements.txt /app/
RUN pip install -r requirements.txt
RUN chmod +x main.py

CMD ["python", "main.py"]
