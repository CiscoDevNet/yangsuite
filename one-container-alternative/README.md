# one-container-alternative

A single-container alternative to YANG Suite's multi-container setup for experimentation and development.

## Quick Start

> [!IMPORTANT]
> All commands must be run from the `one-container-alternative` directory, **not** the repository root.

```bash
# Navigate to the one-container-alternative directory
cd one-container-alternative

# Build and run YANG Suite
make build
make run
```

Then visit <https://localhost:8480> and login with:

- **Username:** `developer`
- **Password:** `developer`

## Overview

This alternative installation uses only a single container instead of three, making it simpler for experimentation.

### Advantages

- Fewer points of failure - one container for all requirements.
- No user input required - configuration settings are preset.
- No Docker/Podman Compose needed - only Docker/Podman commands.
- HTTPs only on port `8480`

### Limitations

- No backup cron job.
- Container runs as root (`/usr/local/bin/create_yangtree` had permissions issues).
- Intended for experimentation, not production.

## Prerequisites

- `Docker` or `Podman` (container runtime).
- `Make` (build automation tool).
- 4GB+ available RAM (recommended).

This command creates and starts the container, exposing YANG Suite on port 8480 (HTTPS only) with a persistent volume for your data.

## Managing the Container

You can control the container lifecycle with these commands:

```bash
make stop    # Stop the running container
make start   # Start the stopped container
make rm      # Remove the container (data persists in volume)
```

## Using Custom Certificates

By default, the container uses self-signed certificates. To use your own SSL certificates:

1. Place **exactly one** `.crt` and **one** `.key` file in the `certificate` directory inside the `one-container-alternative` directory.
2. Run `make run` - your certificates will be automatically detected and used.

> [!NOTE]
> The container automatically detects custom certificates. If none are found, it falls back to self-signed certificates.

## Troubleshooting & Logs

### "make: command not found" or "No such file or directory"

You're probably in the wrong directory. Make sure you're in `one-container-alternative`:

```bash
# Check your current directory
pwd

# If you're in the repository root, navigate to the subdirectory:
cd one-container-alternative

# Verify you can see the Makefile:
ls Makefile
```

#### Expected directory structure

```text
yangsuite/                          # Repository root
├── README.md                       # Main YANG Suite README
├── docker/                         # Main Docker setup
└── one-container-alternative/      # ← You should be here
    ├── Dockerfile
    ├── Makefile                    # ← This should exist
    ├── README.md                   # ← This file
    └── build-assets/
```

### Viewing Logs

Watch real-time application logs:

```bash
make follow    # View container logs (Ctrl+C to stop)
```

Access internal YANG Suite logs:

```bash
make debug     # Monitor internal application logs
```

Get shell access for debugging:

```bash
make cli       # Open bash shell inside container
```

## Data Persistence

Your YANG Suite data is stored in the Docker volume `yangsuite-one-container-data`. This means:

- Settings and configurations persist between container restarts.
- Data survives container removal (unless you run `make rm-volume`).
- You can backup/restore data by managing this volume.

## Quick Development Workflow

For development and testing, use this command to rebuild and restart everything:

```bash
make dev       # Removes container+volume, rebuilds, runs, and follows logs
```

> [!WARNING] > `make dev` removes all data! Only use for development.
