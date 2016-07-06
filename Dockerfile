FROM php:7.0-cli
MAINTAINER Denis Smetannikov <admin@jbzoo.com>

RUN apt-get update          \
    && apt-get install -y   \
        git                 \
        unzip               \
        mc                  \
    && apt-get clean

# Goto temporary directory.
WORKDIR /tmp

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

RUN composer require phpunit/phpunit    \
    --no-ansi                           \
    --no-interaction

RUN ln -s /tmp/vendor/bin/phpunit /usr/local/bin/phpunit

# Set up the application directory.
VOLUME ["/app"]
WORKDIR /app

# Set up the command arguments.
ENTRYPOINT ["/usr/local/bin/phpunit"]
CMD ["--help"]
