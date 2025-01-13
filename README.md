# Inception
This project aims to broaden your knowledge of system administration by using Docker. You will virtualize several Docker images, creating them in your new personal virtual machine.

## About the project
This project focuses on system administration using Docker, requiring students to set up a small infrastructure composed of different services under specific rules. The main goal is to run multiple services using Docker Compose, including **NGINX** with TLSv1.2 or TLSv1.3, **WordPress** + php-fpm, and **MariaDB**.

<div align="center">
  <img src="https://github.com/user-attachments/assets/e10a215b-b9f4-455c-96c0-816db6518b5d">
  <p><em>Wordpress homepage</em></p>
</div>


### Key Requirements
- Set up three Docker containers that run NGINX, WordPress, and MariaDB
- Configure containers to restart on failure
- Use Docker volumes for the WordPress database and website files
- Set up a docker-network to establish connection between containers
- Use environment variables through .env file
- Configure NGINX with TLS 1.2 or TLS 1.3
- Set up WordPress with php-fpm
- Ensure data persistence through volumes

### Bonus features
- Redis cache for WordPress
- FTP server
- Adminer
- Ollama (Choosen service)
- AI Chat interface (Static website)

### Skills Learned
- Docker and container orchestration
- System administration
- Network configuration
- Security implementation (TLS)
- Database management
- Environment variable usage
- Service configuration
- Docker Compose
- Virtual machine management
