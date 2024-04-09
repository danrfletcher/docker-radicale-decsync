# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Install Radicale and the radicale_storage_decsync plugin
RUN pip install --no-cache-dir radicale radicale_storage_decsync

# Expose port 5232
EXPOSE 5232

# Create Radicale config directory and configuration files
RUN mkdir -p /root/.config/radicale
RUN echo "[storage]\ntype = radicale_storage_decsync\nfilesystem_folder = /root/.var/lib/radicale/collections\ndecsync_dir = /root/.local/share/decsync\n\n[server]\nhosts = 0.0.0.0:5232" > /root/.config/radicale/config

# Volume for DecSync directory
VOLUME ["/root/.local/share/decsync"]

# Start Radicale server
CMD ["python3", "-m", "radicale", "--config", "/root/.config/radicale/config"]
