# PostgreSQL Docker Setup

Minimal Docker Compose setup for PostgreSQL 18 with pgAdmin4.

## Requirements

### Software

- Docker
- Docker Compose
- Just (command runner)

### System

- RAM: 1GB minimum (512MB PostgreSQL + 512MB pgAdmin4)
- Disk: 1GB+ for data storage
- CPU: 1 core minimum

### PaaS Compatibility

⚠️ **Not suitable for free-tier PaaS** (Heroku, Railway, Render, Fly.io):

- Most free tiers provide 256-512MB RAM (insufficient for both services)
- Ephemeral filesystems cause data loss on restart
- Docker Compose not supported on many platforms
- Use managed PostgreSQL services instead for production

## Quick Start

```bash
just  # Setup and start
```

## Access

- PostgreSQL: `localhost:5432`
- pgAdmin4: `http://localhost:16543`
- Connection URL: `postgresql://postgres:postgres@localhost:5432/postgres`

## Configuration

⚠️ Edit environment files before deployment:

- `postgres.env` - Database credentials
- `pgadmin4.env` - pgAdmin login
