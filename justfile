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

# Nuclear clean - removes ALL Docker resources (containers, images, volumes, networks)
nuke:
    @echo "WARNING: This will remove ALL Docker containers, images, volumes, and networks!"
    @echo "Press Ctrl+C to cancel, or wait 5 seconds to continue..."
    @sleep 5
    docker compose down -v --remove-orphans
    docker stop $(docker ps -aq) 2>/dev/null || true
    docker rm $(docker ps -aq) 2>/dev/null || true
    docker rmi $(docker images -q) 2>/dev/null || true
    docker volume rm $(docker volume ls -q) 2>/dev/null || true
    docker network prune -f
    docker system prune -af --volumes
    sudo rm -rf ./data
    @echo "All Docker resources have been removed"