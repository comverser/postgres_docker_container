default:
    @git pull --rebase --autostash
    @just setup && just up

setup:
    #!/usr/bin/env bash
    set -euo pipefail
    [ ! -f postgres.env ] && cp postgres.env.example postgres.env || true
    [ ! -f pgadmin4.env ] && cp pgadmin4.env.example pgadmin4.env || true
    chmod 600 postgres.env pgadmin4.env 2>/dev/null || true
    [ -d servers.json ] && sudo rm -rf servers.json || true
    . ./postgres.env
    {
        printf '{\n'
        printf '  "Servers": {\n'
        printf '    "1": {\n'
        printf '      "Name": "postgres_server",\n'
        printf '      "Group": "Servers",\n'
        printf '      "Host": "postgres",\n'
        printf '      "Port": 5432,\n'
        printf '      "MaintenanceDB": "%s",\n' "$POSTGRES_DB"
        printf '      "Username": "%s",\n' "$POSTGRES_USER"
        printf '      "SSLMode": "prefer"\n'
        printf '    }\n'
        printf '  }\n'
        printf '}\n'
    } > servers.json

up:
    @mkdir -p data
    @docker compose up -d

down:
    @docker compose down

logs:
    @docker compose logs -f

psql:
    @docker compose exec postgres psql -U postgres -d postgres

backup:
    @docker compose exec -T postgres pg_dumpall -U postgres > backup_$(date +%Y%m%d_%H%M%S).sql

clean:
    #!/usr/bin/env bash
    set -euo pipefail
    read -p "⚠ Delete all data? (yes): " c
    [ "$c" = "yes" ] || exit 1
    docker compose down -v && sudo rm -rf data

nuke:
    #!/usr/bin/env bash
    set -euo pipefail
    read -p "⚠ Remove ALL Docker resources? (yes): " c
    [ "$c" = "yes" ] || exit 1
    docker compose down -v 2>/dev/null || true
    docker stop $(docker ps -aq) 2>/dev/null || true
    docker rm $(docker ps -aq) 2>/dev/null || true
    docker volume rm $(docker volume ls -q) 2>/dev/null || true
    docker network rm $(docker network ls -q) 2>/dev/null || true
    docker rmi $(docker images -aq) 2>/dev/null || true
    docker system prune -af --volumes
    sudo rm -rf data