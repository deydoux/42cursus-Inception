NAME = Inception
DOMAIN_NAME = deydoux.42.fr

COMPOSE = docker compose --project-directory srcs
MKDIR = mkdir -p
OPENSSL = openssl
RM = rm -rf
SED = sed

SECRETS = secrets

COMPOSE_COMMANDS = build config create down events images kill logs ls pause ps restart start stats stop top unpause up

all: $(NAME)

$(NAME): $(SECRETS)
	$(COMPOSE) up --build

$(SECRETS): $(SECRETS)/cert.key $(SECRETS)/cert.pem $(SECRETS)/initfile.sql

$(SECRETS)/cert.key $(SECRETS)/cert.pem:
	@$(MKDIR) $(@D)
	$(OPENSSL) req -x509 -newkey rsa:4096 -keyout $(@D)/cert.key -out $(@D)/cert.pem -sha256 -days 397 -nodes -subj "/CN=$(DOMAIN_NAME)"

$(SECRETS)/initfile.sql: $(SECRETS).sample/initfile.sql $(SECRETS)/password_db_root.txt $(SECRETS)/password_db_wordpress.txt $(SECRETS)/password_wordpress_deydoux.txt $(SECRETS)/password_wordpress_root.txt
	@$(MKDIR) $(@D)
	$(SED) -e "s/%ROOT_PASSWORD/$(shell cat $(word 2, $^))/g" -e "s/%WORDPRESS_PASSWORD/$(shell cat $(word 3, $^))/g" $< > $@

$(SECRETS)/password_%.txt:
	@$(MKDIR) $(@D)
	$(OPENSSL) rand -hex 128 > "$@"

$(COMPOSE_COMMANDS):
	$(COMPOSE) $@

clean:
	$(COMPOSE) down --rmi all -v
	$(RM) $(SECRETS)

re: clean all

.PHONY: all $(NAME) $(COMPOSE_COMMANDS) clean re
