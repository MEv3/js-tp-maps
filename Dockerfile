FROM php:8.2-fpm-alpine

# Installer les extensions PDO MySQL
RUN docker-php-ext-install pdo pdo_mysql mysqli

# Installer Xdebug
RUN apk add --no-cache $PHPIZE_DEPS linux-headers \
    && pecl install xdebug-3.3.1 \
    && docker-php-ext-enable xdebug

# Configuration Xdebug de base (sans client_host qui sera défini dynamiquement)
RUN echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_port=9003" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.log=/tmp/xdebug.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.log_level=7" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Script de démarrage avec détection automatique améliorée
RUN echo '#!/bin/sh' > /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo 'set -e' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '# Détection automatique du client_host pour Xdebug' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo 'if [ -z "$XDEBUG_CLIENT_HOST" ]; then' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '  # Vérifier si nous sommes dans un environnement virtuel (Codespaces, GitPod, etc.)' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '  if [ -d /workspaces ] || [ -n "$CODESPACE_NAME" ] || [ -n "$GITPOD_WORKSPACE_ID" ]; then' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '    # Environnement cloud - utiliser la gateway' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '    export XDEBUG_CLIENT_HOST=$(ip route | grep default | awk "{print \$3}" | head -n1)' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '    echo "[Xdebug] Cloud environment detected (Codespaces/GitPod)"' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '    echo "[Xdebug] Using gateway IP: $XDEBUG_CLIENT_HOST"' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '  else' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '    # Essayer host.docker.internal (Mac/Windows/WSL2)' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '    if getent hosts host.docker.internal >/dev/null 2>&1; then' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '      export XDEBUG_CLIENT_HOST=host.docker.internal' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '      echo "[Xdebug] Using host.docker.internal (Docker Desktop)"' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '    else' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '      # Fallback sur la gateway' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '      export XDEBUG_CLIENT_HOST=$(ip route | grep default | awk "{print \$3}" | head -n1)' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '      echo "[Xdebug] Using gateway IP: $XDEBUG_CLIENT_HOST (Linux native)"' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '    fi' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '  fi' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo 'else' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '  echo "[Xdebug] Using manual configuration: $XDEBUG_CLIENT_HOST"' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo 'fi' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '# Écrire la configuration finale' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo 'echo "xdebug.client_host=$XDEBUG_CLIENT_HOST" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo 'echo "[Xdebug] Configuration: client_host=$XDEBUG_CLIENT_HOST, client_port=9003"' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo '# Démarrer PHP-FPM' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && echo 'exec php-fpm' >> /usr/local/bin/docker-php-entrypoint-xdebug \
    && chmod +x /usr/local/bin/docker-php-entrypoint-xdebug

WORKDIR /code

EXPOSE 9000

CMD ["/usr/local/bin/docker-php-entrypoint-xdebug"]