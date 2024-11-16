NAME = Inception
DOMAIN_NAME = deydoux.42.fr

COMPOSE = docker compose --project-directory srcs
MKDIR = mkdir -p
OPENSSL = openssl
RM = rm -rf
SED = sed

SECRETS_DIR = secrets

COMPOSE_COMMANDS = build config create down events images kill logs ls pause ps restart start stats stop top unpause up

all: $(NAME)

$(NAME): $(SECRETS_DIR)
	$(COMPOSE) up --build

$(SECRETS_DIR): $(SECRETS_DIR)/cert.key $(SECRETS_DIR)/cert.pem $(SECRETS_DIR)/initfile.sql

$(SECRETS_DIR)/cert.key $(SECRETS_DIR)/cert.pem:
	@$(MKDIR) $(@D)
	$(OPENSSL) req -x509 -newkey rsa:4096 -keyout $(@D)/cert.key -out $(@D)/cert.pem -sha256 -days 397 -nodes -subj "/CN=$(DOMAIN_NAME)"

$(SECRETS_DIR)/initfile.sql: $(SECRETS_DIR).sample/initfile.sql $(SECRETS_DIR)/password_db_root.txt $(SECRETS_DIR)/password_db_wordpress.txt $(SECRETS_DIR)/password_wordpress_deydoux.txt $(SECRETS_DIR)/password_wordpress_root.txt
	@$(MKDIR) $(@D)
	$(SED) -e "s/%ROOT_PASSWORD/$(shell cat $(word 2, $^))/g" -e "s/%WORDPRESS_PASSWORD/$(shell cat $(word 3, $^))/g" $< > $@

$(SECRETS_DIR)/password_%.txt:
	@$(MKDIR) $(@D)
	$(OPENSSL) rand -hex 128 > "$@"

$(COMPOSE_COMMANDS):
	$(COMPOSE) $@

clean:
	$(COMPOSE) down --rmi all -v
	$(RM) $(SECRETS_DIR)

re: clean all

.PHONY: all $(NAME) $(COMPOSE_COMMANDS) clean re
