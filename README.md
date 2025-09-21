# PostgreSQL Docker Compose Setup

This repository offers a Docker Compose configuration designed to simplify the deployment of a PostgreSQL database within a Docker container. It's an ideal solution for both development and production environments, ensuring a seamless PostgreSQL setup process.

The setup presented here draws inspiration from Cadu Magalhães's comprehensive guide on setting up a PostgreSQL database using Docker Compose. For more detailed insights, visit [Cadu Magalhães's blog](https://blog.cadumagalhaes.dev/how-to-setup-a-postgresql-database-with-docker-compose).

## Prerequisites

- Docker and Docker Compose
- [just](https://github.com/casey/just) command runner (optional, but recommended)

## Getting Started

To initialize the PostgreSQL database container, ensure you have Docker and Docker Compose installed on your system. Then, follow the steps below:

### Environment Setup

Configure your environment variables using .env.example files according to your requirements:
```bash
# Copy and configure PostgreSQL environment
cp postgres.env.example postgres.env
# Edit postgres.env with your database credentials

# (Optional) For pgAdmin4:
cp pgadmin4.env.example pgadmin4.env
# Edit pgadmin4.env with your pgAdmin credentials
```

### Launch Containers

Run the following command to start the PostgreSQL database container in detached mode:
```bash
# Initialize data directory and start containers
just up
```

### Container Management

```bash
# View container logs
just logs

# Connect to PostgreSQL
just psql

# Check environment variables in containers
just env-check
```

### Database Connection

With the default `postgres.env.example` configuration:
```
postgresql://root:postgres@localhost:5432/postgres
```

### Shutdown and Cleanup

To stop and remove the containers:
```bash
# Stop containers
just down

# Remove containers, volumes and data
just clean

# Remove everything including images
just clean-all
```

## Configuration

### PostgreSQL

Edit `postgres.env` to configure:
- `POSTGRES_USER`: Database user (default: postgres)
- `POSTGRES_PASSWORD`: Database password
- `POSTGRES_DB`: Default database name

### pgAdmin4 (Optional)

To enable pgAdmin4 web interface:
1. Uncomment the pgAdmin4 service in `docker-compose.yaml`
2. Copy and configure the environment file:
   ```bash
   cp pgadmin4.env.example pgadmin4.env
   # Edit pgadmin4.env with your credentials
   ```
3. Access pgAdmin4 at `http://localhost:16543`

## Environment Variables Check

After setting up the containers, you can verify the environment variables within the PostgreSQL and pgAdmin4 containers by executing:

```bash
just env-check
```

This will output the list of environment variables currently set in each container, allowing you to confirm their configuration.