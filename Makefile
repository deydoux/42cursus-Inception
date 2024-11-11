NAME = Inception

COMPOSE = docker compose --project-directory srcs

all: $(NAME)

$(NAME):
	$(COMPOSE) up --build

clean:

fclean:

re: fclean all

.PHONY: all clean fclean re
