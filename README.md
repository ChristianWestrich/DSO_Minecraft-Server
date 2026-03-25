# 🎮 Minecraft Java Server — Docker Setup

This repository provides a containerized setup for a **Minecraft Java Edition** server. It uses a custom `Dockerfile` to build a minimal environment to run your `server.jar`.

## Table of Contents

- [Description](#description)
- [Project Contents](#project-contents)
- [Quickstart](#quickstart)
- [Usage & Configuration](#usage--configuration)
  - [Prerequisites](#prerequisites)
  - [Environment Variables](#environment-variables)
  - [Modifying Configuration](#modifying-configuration)
  - [Data Persistence](#data-persistence)
- [Commands](#commands)

---

## Description

The purpose of this repository is to offer a simple, **Docker-based deployment** for a Minecraft Java server. Instead of manually installing Java and managing dependencies, you can launch a fully functional server with a single command. 

**Key Features:**
- **Customized Container**: Uses `eclipse-temurin:25-jre` for a modern, lightweight Java environment.
- **Environment Driven**: Configure server memory and settings via a `.env` file.
- **Persistence**: Game data and configurations are stored in a Docker volume, ensuring your world remains intact between restarts.

---

## Project Contents

- `Dockerfile`: Defines the server's runtime environment.
- `docker-compose.yaml`: Orchestrates the server container and volumes.
- `minecraft-server-entrypoint.sh`: A script that handles EULA acceptance and starts the server with specified memory flags.
- `server.jar`: The Minecraft server executable (ensure this is present in the root).
- `.env.template`: A template for your environment configuration.
- `server.properties`: The main configuration file for Minecraft server settings.

---

## Quickstart

### 1. Prerequisites
- [Docker](https://www.docker.com/) and Docker Compose installed.
- A `server.jar` file in the project root directory.

### 2. Setup Environment
Copy the template to create your `.env` file:
```bash
cp .env.template .env
```

### 3. Launch the Server
Start the container in detached mode:
```bash
docker-compose up --build
```

The server is ready once you see `Starting Server...` followed by the Minecraft console output. By default, it's accessible via `localhost:8888`.

---

## Usage & Configuration

### Prerequisites
| Tool | Recommended Version |
|------|--------------------|
| Docker | 24.x or higher |
| Docker Compose | 2.x or higher |

### Environment Variables
The server is primarily configured via the `.env` file. The following variables are supported:

| Variable | Default (Template) | Description |
|----------|-------------------|-------------|
| `EULA` | `true` | Set to `true` to accept the Minecraft End User License Agreement. |
| `MEMORY_MAX` | `4G` | Maximum RAM allocated to the JVM (e.g., `2G`, `4096M`). |
| `MEMORY_MIN` | `1G` | Initial RAM allocated to the JVM. |
| `NOGUI` | `true` | Whether to start the server without the graphical user interface (recommended for Docker). |

### Modifying Configuration
To achieve different results or optimize performance:

1.  **Adjust RAM**: For larger servers or many plugins/mods, increase `MEMORY_MAX` in `.env`.
    - *Example*: `MEMORY_MAX=8G`
2.  **Server Settings**: Modify `server.properties` directly in the project root. Changes take effect after a restart.
    - *Example*: Change `view-distance` or `difficulty`.
3.  **Port Mapping**: If port `8888` is occupied, change the host port in `docker-compose.yaml`:
    ```yaml
    ports:
      - "25565:25565" # Changes the external port to the Minecraft default
    ```

### Data Persistence
All world data and server settings are stored in the `data` volume defined in `docker-compose.yaml`. This is mapped to `/mc-server` inside the container, where the game files reside.

---

## Commands

| Action | Command                     |
|--------|-----------------------------|
| Start Server | `docker-compose up --build` |
| Stop Server | `docker-compose down`       |
| View Logs | `docker-compose logs -f`    |
| Restart Server | `docker-compose restart`    |