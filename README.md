<div align="center">
  <img height="128" width="128" src="https://github.com/user-attachments/assets/15b75e24-5703-4470-9367-2033b7d87a43">
  <h1>Inception</h1>
  <p>This project aims to broaden your knowledge of system administration by using Docker. You will virtualize several Docker images, creating them in your new personal virtual machine.</p>
</div>

## About the project
This project focuses on system administration using Docker, requiring students to set up a small infrastructure composed of different services under specific rules. The main goal is to run multiple services using Docker Compose, including **NGINX** with TLSv1.2 or TLSv1.3, **WordPress** + php-fpm, and **MariaDB**.

<div align="center">
  <img src="https://github.com/user-attachments/assets/9ebeda10-2314-4ee2-b501-b8f3d33b38be">
  <p><em>WordPress homepage</em></p>
</div>

### Key Requirements
- Set up three Docker containers that run NGINX, WordPress, and MariaDB
- Configure containers to restart on failure
- Use Docker volumes for the WordPress database and website files
- Set up a Docker network to establish connection between containers
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

| ![Inception Chat](https://github.com/user-attachments/assets/12df4bc5-1d87-4c20-a235-24b553d3878f) | ![Adminer](https://github.com/user-attachments/assets/6d9541a2-6e86-463e-86ce-42657be62655) |
| - | - |
| <p align="center"><em>Inception Chat</em></p> | <p align="center"><em>Adminer</em></p> |

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

## Getting started
### Requirements
- [Docker](https://docs.docker.com/get-started/get-docker/)
- OpenSSL

```bash
sudo echo "127.0.0.1 deydoux.42.fr" >> /etc/hosts
```

### Start
```bash
make    # Start attached
make up # Start detached
```

**URLs**
- [WordPress](https://deydoux.42.fr)
- [WordPress Admin](https://deydoux.42.fr/wp-admin)
  - Password generated for `root` user in `secrets/password_wordpress_root.txt`
- [Adminer](https://deydoux.42.fr/adminer) file
  - Password generated for `root` user at `mariadb` host in `secrets/password_db_root.txt` file
- [Inception Chat](https://deydoux.42.fr/chat)

### Stop
```bash
make down
make clean # Remove images and volumes
```

## Credit
<img align="right" src="https://github.com/user-attachments/assets/3c1a2901-1547-41d0-b036-70b243528299">

- [42](https://42.fr/)

### Docs
- [NGINX](https://nginx.org/en/docs/)
- [How to Configure PHP-FPM with NGINX](https://www.digitalocean.com/community/tutorials/php-fpm-nginx)
- [How to install WordPress](https://developer.wordpress.org/advanced-administration/before-install/howto-install/)
- [WP-CLI](https://wp-cli.org/)
- [Ollama API](https://github.com/ollama/ollama/blob/main/docs/api.md)
- [ProFTPd](http://www.proftpd.org/docs/directives/index.html)
