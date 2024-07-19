# PostgreSQL Docker Compose Setup

This repository offers a Docker Compose configuration designed to simplify the deployment of a PostgreSQL database within a Docker container. It's an ideal solution for both development and production environments, ensuring a seamless PostgreSQL setup process.

The setup presented here draws inspiration from Cadu Magalhães's comprehensive guide on setting up a PostgreSQL database using Docker Compose. For more detailed insights, visit [Cadu Magalhães's blog](https://blog.cadumagalhaes.dev/how-to-setup-a-postgresql-database-with-docker-compose).

## Getting Started

To initialize the PostgreSQL database container, ensure you have Docker and Docker Compose installed on your system. Then, follow the steps below:

1. **Environment Setup**: Configure your environment variables using `.env.example` files according to your requirements.

2. **Launch Containers**: Run the following command to start the PostgreSQL database container in detached mode:

   ```bash
   docker compose up -d
   ```

3. **Shutdown and Cleanup**: To stop and remove the containers, along with their associated images and volumes, execute:

   ```bash
   docker compose down --rmi all --volumes
   ```

   If you need to reset the data directory permissions or remove it entirely, use:

   ```bash
   sudo chown -R <owner>:<group> data
   rm -rf data
   ```

## Environment Variables Check

After setting up the containers, you can verify the environment variables within the PostgreSQL and pgAdmin4 containers by executing:

```bash
docker exec postgres_container env
```

```bash
docker exec pgadmin4_container env
```

This will output the list of environment variables currently set in each container, allowing you to confirm their configuration.

## Conclusion

By following these instructions, you can quickly get a PostgreSQL database running inside a Docker container, making it a straightforward process to manage your database environment for any project.
