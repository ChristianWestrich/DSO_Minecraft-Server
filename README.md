# 🎮 Minecraft Java Server — Docker Setup

## Table of Contents

- [Description](#description)
- [Quickstart](#quickstart)
- [Usage](#usage)
  - [Prerequisites](#prerequisites)
  - [Configuration](#configuration)
  - [Starting & Stopping](#starting--stopping)
  - [Data Persistence](#data-persistence)
  - [Checking Server Status](#checking-server-status)

---

## Description

This repository contains a Docker-based setup for a **Minecraft Java Edition multiplayer server**. The goal is to provide a fully configurable and persistent Minecraft server with minimal effort — locally or on a cloud VM.

Key contents:

- `docker-compose.yml` — Defines the Minecraft service based on the official [`itzg/minecraft-server`](https://github.com/itzg/docker-minecraft-server) image
- Automatic download of the server JAR on first start
- Persistent world data via volume mount (`./data`)
- Automatic restart on failure (`restart: unless-stopped`)

---

## Quickstart

**Prerequisites:**

- [Docker](https://www.docker.com/) & Docker Compose installed
- Port `8888` open on the host

**Start the server:**

```bash
docker compose up -d
```

**Check status:**

```bash
docker compose logs -f mc-server
```

Once `Done! For help, type "help"` appears, the server is reachable at:

```
localhost:8888
```

---

## Usage

### Prerequisites

| Tool | Version |
|------|---------|
| Docker | ≥ 24.x |
| Docker Compose | ≥ 2.x |

For testing via Python additionally:

```bash
pip install mcstatus
```

---

### Configuration

All configuration is done in `docker-compose.yml`:

```yaml
services:
  mc-server:
    image: itzg/minecraft-server
    tty: true
    stdin_open: true
    ports:
      - "8888:25565"
    environment:
      EULA: "TRUE"
    volumes:
      - ./data:/data
    restart: unless-stopped

volumes:
  data:
```

**Key parameters:**

| Parameter | Description | Example change |
|-----------|-------------|----------------|
| `8888:25565` | External port : internal Minecraft port | `25565:25565` for default |
| `EULA: "TRUE"` | Accepts the Minecraft EULA (required) | Do not change |
| `./data:/data` | Local folder for world data & config | Any valid path |
| `restart: unless-stopped` | Restart policy on crash | `always` or `on-failure` |

**Pin a specific Minecraft version:**

By default the latest version is downloaded. To use a specific version:

```yaml
environment:
  EULA: "TRUE"
  VERSION: "1.20.4"
```

**Change server type** (e.g. Paper for better performance):

```yaml
environment:
  EULA: "TRUE"
  TYPE: "PAPER"
```

**Adjust RAM:**

```yaml
environment:
  EULA: "TRUE"
  MEMORY: "2G"
```

---

### Starting & Stopping

```bash
# Start in background
docker compose up -d

# Follow live logs
docker compose logs -f mc-server

# Stop
docker compose down

# Stop + delete volumes (world data will be lost!)
docker compose down -v
```

---

### Data Persistence

The world data, configuration and all server settings are stored in the `./data` folder on the host. This folder is retained even after `docker compose down`.

Manual configuration of `server.properties` is possible — the file is available under `./data/server.properties` after the first start.

---

### Checking Server Status

Using the Python module [`mcstatus`](https://github.com/py-mine/mcstatus):

```python
from mcstatus import JavaServer

server = JavaServer.lookup("localhost:8888")
status = server.status()
print(f"Version: {status.version.name}")
print(f"Players online: {status.players.online}/{status.players.max}")
```

On a cloud VM, use the VM's IP address instead of `localhost`:

```python
server = JavaServer.lookup("123.456.789.0:8888")
```