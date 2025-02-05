MAKEFLAGS += --no-print-directory

ifeq (,$(wildcard .env))
$(error File .env not found!)
endif

include .env

ECOMMERCE_BACKEND = ../ecommerce-backend
ECOMMERCE_FRONTEND = ../ecommerce-frontend
EDITOR_BACKEND_API = ../editor-backend-api
EDITOR_FRONTEND = ../editor-frontend

build:
	make down;
	@if [ "$(filter nocache,$(MAKECMDGOALS))" ]; then \
		docker compose -f docker-compose.yml build --no-cache; \
	else \
		docker compose -f docker-compose.yml build; \
	fi
	make up
	make ps
	@echo Build finished!
	@echo

nocache:
	@:

up_ecommerce:
	make down_ecommerce
	@if [ ! -f $(ECOMMERCE_BACKEND)/.env ]; then \
		cp $(ECOMMERCE_BACKEND)/.env.example $(ECOMMERCE_BACKEND)/.env.local; \
		cp $(ECOMMERCE_BACKEND)/.env.example $(ECOMMERCE_BACKEND)/.env; \
	fi
	@sed -i 's/^APP_ENV=.*/APP_ENV=development/' $(ECOMMERCE_BACKEND)/.env || echo "APP_ENV=development" >> $(ECOMMERCE_BACKEND)/.env
	@grep -q '^APP_EMPRESA=' $(ECOMMERCE_BACKEND)/.env || echo "APP_EMPRESA=18" >> $(ECOMMERCE_BACKEND)/.env
	@if [ ! -f $(ECOMMERCE_BACKEND)/config/database-local.original.php ]; then \
  		cp $(ECOMMERCE_BACKEND)/config/database-local.php $(ECOMMERCE_BACKEND)/config/database-local.original.php; \
  	fi
	@if [ ! -f $(ECOMMERCE_BACKEND)/config/18/database-local.original.php ]; then \
  		cp $(ECOMMERCE_BACKEND)/config/18/database-local.php $(ECOMMERCE_BACKEND)/config/18/database-local.original.php; \
  	fi
	@echo "**/*.original.php" >> $(ECOMMERCE_BACKEND)/config/.gitignore
	sed -i 's/172.31.0.89/'"$(shell grep '^DB_HOST=' .env | cut -d '=' -f2)"'/g' $(ECOMMERCE_BACKEND)/config/database-local.php
	sed -i 's/usr_web/'"$(shell grep '^DB_USERNAME=' .env | cut -d '=' -f2)"'/g' $(ECOMMERCE_BACKEND)/config/database-local.php
	sed -i 's/web_usr/'"$(shell grep '^DB_PASSWORD=' .env | cut -d '=' -f2)"'/g' $(ECOMMERCE_BACKEND)/config/database-local.php
	sed -i 's/172.31.0.89/'"$(shell grep '^DB_HOST=' .env | cut -d '=' -f2)"'/g' $(ECOMMERCE_BACKEND)/config/18/database-local.php
	sed -i 's/usr_web/'"$(shell grep '^DB_USERNAME=' .env | cut -d '=' -f2)"'/g' $(ECOMMERCE_BACKEND)/config/18/database-local.php
	sed -i 's/web_usr/'"$(shell grep '^DB_PASSWORD=' .env | cut -d '=' -f2)"'/g' $(ECOMMERCE_BACKEND)/config/18/database-local.php
	@echo - ecommerce_backend [up]
	@if [ ! -f $(ECOMMERCE_FRONTEND)/src/config/development.original.js ]; then \
  		cp $(ECOMMERCE_FRONTEND)/src/config/development.js $(ECOMMERCE_FRONTEND)/src/config/development.original.js; \
  	fi
	@echo "**/*.original.php" >> $(ECOMMERCE_FRONTEND)/src/config/.gitignore
	sed -i "s|\(editor:\s*\).*|editor: 'http://editor-frontend.fabricadolivro.com.br/index.php?trabalho=',|" $(ECOMMERCE_FRONTEND)/src/config/development.js
	sed -i "s|\(loja:\s*\).*|loja: 'http://ecommerce-backend.fabricadolivro.com.br/api',|" $(ECOMMERCE_FRONTEND)/src/config/development.js
	@echo - ecommerce_frontend [up]
	@echo

down_ecommerce:
	@if [ -f $(ECOMMERCE_BACKEND)/.env.local ]; then \
		rm -f $(ECOMMERCE_BACKEND)/.env.local; \
		rm -f $(ECOMMERCE_BACKEND)/.env; \
	fi
	@if [ -f $(ECOMMERCE_BACKEND)/config/database-local.original.php ]; then \
        cp $(ECOMMERCE_BACKEND)/config/database-local.original.php $(ECOMMERCE_BACKEND)/config/database-local.php; \
      	rm -f $(ECOMMERCE_BACKEND)/config/database-local.original.php; \
    fi
	@if [ -f $(ECOMMERCE_BACKEND)/config/18/database-local.original.php ]; then \
        cp $(ECOMMERCE_BACKEND)/config/18/database-local.original.php $(ECOMMERCE_BACKEND)/config/18/database-local.php; \
      	rm -f $(ECOMMERCE_BACKEND)/config/18/database-local.original.php; \
    fi
	@if [ -f $(ECOMMERCE_BACKEND)/config/.gitignore ]; then rm $(ECOMMERCE_BACKEND)/config/.gitignore; fi
	@echo - ecommerce_backend [down]
	@if [ -f $(ECOMMERCE_FRONTEND)/src/config/development.original.js ]; then \
        cp $(ECOMMERCE_FRONTEND)/src/config/development.original.js $(ECOMMERCE_FRONTEND)/src/config/development.js; \
      	rm -f $(ECOMMERCE_FRONTEND)/src/config/development.original.js; \
    fi
	@if [ -f $(ECOMMERCE_FRONTEND)/src/config/.gitignore ]; then rm $(ECOMMERCE_FRONTEND)/src/config/.gitignore; fi
	@echo - ecommerce_frontend [down]
	@echo

up_editor:
	make down_editor
	@if [ ! -f $(EDITOR_BACKEND_API)/.env ]; then \
		cp $(EDITOR_BACKEND_API)/.env.example $(EDITOR_BACKEND_API)/.env.local; \
		cp $(EDITOR_BACKEND_API)/.env.example $(EDITOR_BACKEND_API)/.env; \
	fi
	sed -i 's/DB_HOST=127.0.0.1/DB_HOST='"$(shell grep '^DB_HOST=' .env | cut -d '=' -f2)"'/g' $(EDITOR_BACKEND_API)/.env
	sed -i 's/DB_PORT=3306/DB_PORT='"$(shell grep '^DB_PORT=' .env | cut -d '=' -f2)"'/g' $(EDITOR_BACKEND_API)/.env
	sed -i 's/DB_USERNAME=homestead/DB_USERNAME='"$(shell grep '^DB_USERNAME=' .env | cut -d '=' -f2)"'/g' $(EDITOR_BACKEND_API)/.env
	sed -i 's/DB_PASSWORD=secret/DB_PASSWORD='"$(shell grep '^DB_PASSWORD=' .env | cut -d '=' -f2)"'/g' $(EDITOR_BACKEND_API)/.env
	@echo '' >> $(EDITOR_BACKEND_API)/.env
	@echo 'FDL_API_URL_LOCAL=http://editor-backend-api.fabricadolivro.com.br/api' >> $(EDITOR_BACKEND_API)/.env
	@#echo 'FDL_API_KEY_LOCAL=$2y$12$aLBOptdEx731qBYwXlO0.4W149uaFpK0nwr47o/da101nZly9BGS' >> $(EDITOR_BACKEND_API)/.env
	@echo - editor-backend-api [up]
	@if [ ! -f $(EDITOR_FRONTEND)/config.original.json ]; then \
  		cp $(EDITOR_FRONTEND)/config.json $(EDITOR_FRONTEND)/config.original.json; \
  	fi
	@echo "**/*.original.php" >> $(EDITOR_FRONTEND)/.gitignore
	sed -i "s|\(\"urlApi\":\s*\).*|\"urlApi\": \"http://editor-backend-api.fabricadolivro.com.br/public/\",|" $(EDITOR_FRONTEND)/config.json
	@echo - editor-frontend [up]
	@echo

down_editor:
	@if [ -f $(EDITOR_BACKEND_API)/.env.local ]; then \
		rm -f $(EDITOR_BACKEND_API)/.env.local; \
		rm -f $(EDITOR_BACKEND_API)/.env; \
	fi
	@echo - editor-backend-api [down]
	@if [ -f $(EDITOR_FRONTEND)/config.original.json ]; then \
        cp $(EDITOR_FRONTEND)/config.original.json $(EDITOR_FRONTEND)/config.json; \
      	rm -f $(EDITOR_FRONTEND)/config.original.json; \
    fi
	@if [ -f $(EDITOR_FRONTEND)/.gitignore ]; then \
        sed -i 's|\*\*\/\*\.original\.php||g' $(EDITOR_FRONTEND)/.gitignore; \
    fi
	@echo - editor-frontend [down]
	@echo

up_admin:
	@echo

down_admin:
	@echo

#   Você só precisa executar down e up se fez alterações na configuração do
#	docker-compose.yml, como mudanças nos volumes, portas ou outros parâmetros
#	que afetam a inicialização do container.

up:
#	make stop_services
#	make up_admin
	make up_ecommerce
	make up_editor
#	@echo "Ajustando permissóes da pasta mongodb..."
#	sudo chown -R 999:999 ./mongodb
#	sudo chmod -R 700 ./mongodb
	docker compose -f docker-compose.yml up -d
#	docker logs <CONTAINER_NAME>
	@echo "-------------------------------------------------------"
	@echo "[php72::ecommerce-backend 1/3] Ajustando permissoes de pasta."
	docker exec -it ${APP_SLUG}-php72 chmod 755 -R /var/www/ecommerce-backend
	docker exec -it ${APP_SLUG}-php72 chown -R ${APP_SLUG}:1000 ecommerce-backend/storage/
	docker exec -it ${APP_SLUG}-php72 chown -R ${APP_SLUG}:1000 ecommerce-backend/bootstrap/
	@echo "[php72::ecommerce-backend 2/3] composer install"
	docker exec -it ${APP_SLUG}-php72 composer install --working-dir=ecommerce-backend
	@echo "[php72::ecommerce-backend 3/3] Key generate"
	docker exec -it ${APP_SLUG}-php72 sh -c "cd ecommerce-backend && php artisan key:generate"
#	@echo "[php72::ecommerce-frontend 1/2] npm install"
#	docker exec -it ${APP_SLUG}-node sh -c "cd ecommerce-frontend && npm install && npm run build-test"
#	@echo "[node::ecommerce-frontend 2/2] Ajustando permissões de pasta."
#	docker exec -it ${APP_SLUG}-node chmod 755 -R /srv/ecommerce-frontend
	docker exec ${APP_SLUG}-node sh -c "cd srv/admin-frontend && npm run dev -- -p 3001 &"
	@echo "-------------------------------------------------------"
	@echo

down:
#	make down_admin
	make down_ecommerce
	make down_editor
	@if [ "$(shell docker ps -q -f name=${APP_SLUG}-php72)" ]; then \
		docker exec -d ${APP_SLUG}-php72 sh -c 'rm -f ecommerce-backend/package-lock.json || true'; \
		docker exec -d ${APP_SLUG}-php72 sh -c 'rm -rf ecommerce-backend/vendor || true'; \
		docker exec -d ${APP_SLUG}-php72 sh -c 'rm -rf ecommerce-backend/storage/app/* || true'; \
		docker exec -d ${APP_SLUG}-php72 sh -c 'rm -rf ecommerce-backend/storage/framework/cache/* || true'; \
		docker exec -d ${APP_SLUG}-php72 sh -c 'rm -rf ecommerce-backend/storage/framework/sessions/* || true'; \
		docker exec -d ${APP_SLUG}-php72 sh -c 'rm -rf ecommerce-backend/storage/framework/testing/* || true'; \
		docker exec -d ${APP_SLUG}-php72 sh -c 'rm -rf ecommerce-backend/storage/framework/views/* || true'; \
		docker exec -d ${APP_SLUG}-php72 sh -c 'rm -rf ecommerce-backend/storage/logs/* || true'; \
		docker exec -d ${APP_SLUG}-php72 sh -c 'rm -f editor-backend-api/package-lock.json || true'; \
		docker exec -d ${APP_SLUG}-php72 sh -c 'rm -rf editor-backend-api/vendor || true'; \
		docker exec -d ${APP_SLUG}-php72 sh -c 'rm -rf editor-backend-api/storage/app/* || true'; \
		docker exec -d ${APP_SLUG}-php72 sh -c 'rm -rf editor-backend-api/storage/framework/cache/* || true'; \
		docker exec -d ${APP_SLUG}-php72 sh -c 'rm -rf editor-backend-api/storage/framework/sessions/* || true'; \
		docker exec -d ${APP_SLUG}-php72 sh -c 'rm -rf editor-backend-api/storage/framework/testing/* || true'; \
		docker exec -d ${APP_SLUG}-php72 sh -c 'rm -rf editor-backend-api/storage/framework/views/* || true'; \
		docker exec -d ${APP_SLUG}-php72 sh -c 'rm -rf editor-backend-api/storage/logs/* || true'; \
	fi
	@if [ "$(shell docker ps -q -f name=${APP_SLUG}-php84)" ]; then \
		docker exec -d ${APP_SLUG}-php84 sh -c 'rm -f admin-backend/package-lock.json || true'; \
		docker exec -d ${APP_SLUG}-php84 sh -c 'rm -rf admin-backend/vendor || true'; \
		docker exec -d ${APP_SLUG}-php84 sh -c 'rm -rf admin-backend/storage/app/* || true'; \
		docker exec -d ${APP_SLUG}-php84 sh -c 'rm -rf admin-backend/storage/framework/cache/* || true'; \
		docker exec -d ${APP_SLUG}-php84 sh -c 'rm -rf admin-backend/storage/framework/sessions/* || true'; \
		docker exec -d ${APP_SLUG}-php84 sh -c 'rm -rf admin-backend/storage/framework/testing/* || true'; \
		docker exec -d ${APP_SLUG}-php84 sh -c 'rm -rf admin-backend/storage/framework/views/* || true'; \
		docker exec -d ${APP_SLUG}-php84 sh -c 'rm -rf admin-backend/storage/logs/* || true'; \
	fi
	@if [ "$(shell docker ps -q -f name=${APP_SLUG}-node)" ]; then \
		docker exec -d ${APP_SLUG}-node sh -c 'rm ecommerce-frontend/next-env.d.ts || true'; \
		docker exec -d ${APP_SLUG}-node sh -c 'rm -r ecommerce-frontend/.next || true'; \
		docker exec -d ${APP_SLUG}-node sh -c 'rm -rf ecommerce-frontend/node_modules || true'; \
		docker exec -d ${APP_SLUG}-node sh -c 'rm admin-frontend/next-env.d.ts || true'; \
		docker exec -d ${APP_SLUG}-node sh -c 'rm -r admin-frontend/.next || true'; \
		docker exec -d ${APP_SLUG}-node sh -c 'rm -rf admin-frontend/node_modules || true'; \
	fi
	docker compose -f docker-compose.yml down --volumes
#   make start_services
	@echo

ps:
	docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Label \"com.docker.compose.service\"}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" | sed 's/\<service\>/SERVICE/g'
	@echo

stop:
	docker compose -f docker-compose.yml stop
#   make start_services
	@echo

nginx_reload:
#   Recarregar configuracoes (alteracoes no conf.d)
	docker exec ${APP_SLUG}-nginx nginx -s reload
#	Recarregar o Nginx sem reiniciar o container:
#   docker compose -f docker-compose.yml restart nginx
#	Se preferir reiniciar o container do Nginx:
#	docker compose restart nginx

docker_rmi:
	make down
#   docker images
#	@echo
	@echo Removing images...
	@if [ "$(shell docker images -q ${APP_SLUG}-php7.2-fpm:latest)" ]; then \
		docker rmi ${APP_SLUG}-php7.2-fpm:latest; \
	else \
		echo "- ${APP_SLUG}-php7.2-fpm:latest [not found]"; \
	fi
	@if [ "$(shell docker images -q ${APP_SLUG}-php8.4-fpm:latest)" ]; then \
		docker rmi ${APP_SLUG}-php8.4-fpm:latest; \
	else \
		echo "- ${APP_SLUG}-php8.4-fpm:latest [not found]"; \
	fi
	@echo

docker_prune:
	make down
#	docker image prune -a
#	docker volume prune
	docker system prune -a --volumes;
	@echo




#run:
#	docker exec -it ${APP_SLUG}-node npm run dev
# 	docker exec -it ${APP_SLUG}-node npm install

frontend:
	docker exec -it ${APP_SLUG}-node /bin/sh -l

backend:
	docker exec -it ${APP_SLUG}-php /bin/sh -l

analyse:
	cd ../ecommerce-backend && composer analyse 2>&1 | tee storage/logs/analyse.log

start_services:
	@if command -v redis-server > /dev/null; then \
		sudo service redis-server start; \
	else \
		echo "redis-server is not installed"; \
	fi
	@if command -v mysql > /dev/null; then \
		sudo service mysql start; \
	else \
		echo "mysql is not installed"; \
	fi
	@if command -v nginx > /dev/null; then \
		sudo service nginx start; \
	else \
		echo "nnginx is not installed"; \
	fi

stop_services:
	@if systemctl is-active --quiet redis-server; then \
		sudo service redis-server stop; \
	else \
		echo "redis-server is not running"; \
	fi
	@if systemctl is-active --quiet mysql; then \
		sudo service mysql stop; \
	else \
		echo "mysql is not running"; \
	fi
	@if systemctl is-active --quiet nginx; then \
		sudo service nginx stop; \
	else \
		echo "nginx is not running"; \
	fi

.PHONY: build up stop down ex analyse purge start_services stop_services