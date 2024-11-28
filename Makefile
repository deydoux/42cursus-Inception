NAME = Inception
DOMAIN_NAME = deydoux.42.fr

COMPOSE = docker compose --project-directory srcs
MKDIR = mkdir -p
OPENSSL = openssl
RM = rm -rf
SED = sed

DATA = ~/data
DATA_DIRS = \
	$(DATA)/adminer \
	$(DATA)/db \
	$(DATA)/ollama \
	$(DATA)/wordpress

SECRETS = secrets

all: $(NAME)

$(NAME): $(DATA_DIRS) $(SECRETS)
	$(COMPOSE) up --build

$(DATA)/%:
	$(MKDIR) $@

$(SECRETS): $(SECRETS)/cert.key $(SECRETS)/cert.pem $(SECRETS)/initfile.sql $(SECRETS)/password_proftpd_root.txt $(SECRETS)/password_wordpress_deydoux.txt $(SECRETS)/password_wordpress_root.txt $(SECRETS)/redis.conf

$(SECRETS)/cert.key $(SECRETS)/cert.pem:
	@$(MKDIR) $(@D)
	$(OPENSSL) req -x509 -newkey rsa:4096 -keyout $(@D)/cert.key -out $(@D)/cert.pem -sha256 -days 397 -nodes -subj "/CN=$(DOMAIN_NAME)"

$(SECRETS)/initfile.sql: $(SECRETS).sample/initfile.sql $(SECRETS)/password_db_root.txt $(SECRETS)/password_db_wordpress.txt
	@$(MKDIR) $(@D)
	$(SED) -e "s/%ROOT_PASSWORD/$(shell cat $(word 2, $^))/g" -e "s/%WORDPRESS_PASSWORD/$(shell cat $(word 3, $^))/g" $< > $@

$(SECRETS)/password_%.txt:
	@$(MKDIR) $(@D)
	$(OPENSSL) rand -hex 64 > "$@"

$(SECRETS)/redis.conf: $(SECRETS).sample/redis.conf $(SECRETS)/password_redis.txt
	@$(MKDIR) $(@D)
	$(SED) -e "s/%REDIS_PASSWORD/$(shell cat $(word 2, $^))/g" $< > $@

clean: $(DATA_DIRS) $(SECRETS)/initfile.sql $(SECRETS)/password_wordpress_deydoux.txt $(SECRETS)/password_wordpress_root.txt $(SECRETS)/redis.conf
	$(COMPOSE) stop
	$(COMPOSE) run --entrypoint "" --no-deps --rm wordpress $(RM) /var/www/wordpress || true
	$(COMPOSE) run --entrypoint "" --no-deps --rm adminer $(RM) /var/www/adminer || true
	$(COMPOSE) run --entrypoint "" --no-deps --rm mariadb $(RM) /var/lib/mysql || true
	$(COMPOSE) run --entrypoint "" --no-deps --rm ollama $(RM) /root/.ollama || true
	$(COMPOSE) down --rmi all -v
	$(RM) $(DATA) $(SECRETS)

re: clean all

.PHONY: all $(NAME) clean re
