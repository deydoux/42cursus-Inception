NAME = Inception
DOMAIN_NAME = deydoux.42.fr

COMPOSE = docker compose --project-directory srcs
MKDIR = mkdir -p
OPENSSL = openssl
RM = rm -rf
SED = sed

SECRETS_DIR = secrets

all: $(NAME)

$(NAME): $(SECRETS_DIR)
	$(COMPOSE) up --build

$(SECRETS_DIR): $(SECRETS_DIR)/cert.key $(SECRETS_DIR)/cert.pem $(SECRETS_DIR)/initfile.sql

$(SECRETS_DIR)/cert.key $(SECRETS_DIR)/cert.pem:
	@$(MKDIR) $(@D)
	$(OPENSSL) req -x509 -newkey rsa:4096 -keyout $(@D)/cert.key -out $(@D)/cert.pem -sha256 -days 397 -nodes -subj "/CN=$(DOMAIN_NAME)"

$(SECRETS_DIR)/initfile.sql: $(SECRETS_DIR).sample/initfile.sql $(SECRETS_DIR)/password_db_root.txt $(SECRETS_DIR)/password_db_wordpress.txt
	@$(MKDIR) $(@D)
	$(SED) -e "s/%ROOT_PASSWORD/$(shell cat $(word 2, $^))/g" -e "s/%WORDPRESS_PASSWORD/$(shell cat $(word 3, $^))/g" $< > $@

$(SECRETS_DIR)/password_%.txt:
	@$(MKDIR) $(@D)
	$(OPENSSL) rand -hex 128 > "$@"

clean:

fclean:
	$(RM) $(SECRETS_DIR)

re: fclean all

.PHONY: all clean fclean re
