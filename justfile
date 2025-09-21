# Start PostgreSQL container
up: init
    docker compose up -d

# Stop PostgreSQL container
down:
    docker compose down

# Initialize data directory
init:
    @mkdir -p ./data
    @echo "Data directory created at ./data"

# Clean up everything (volumes and data)
clean:
    docker compose down -v
    sudo rm -rf ./data

# Clean up everything including images
clean-all:
    docker compose down --rmi all --volumes
    sudo rm -rf ./data

# Check environment variables in containers
env-check:
    @echo "PostgreSQL container environment:"
    docker exec postgres_container env
    @echo "\npgAdmin4 container environment (if running):"
    -docker exec pgadmin4_container env 2>/dev/null || echo "pgAdmin4 container not running"

# Show logs
logs:
    docker compose logs -f

# Connect to PostgreSQL
psql:
    docker exec -it postgres_container psql -U root -d postgres