#!/bin/bash

# TODO documentare
# documentare tutto il processo di setup del framework
#

## pulizia schermo
clear

## livelli per la root del sito
RL="../../"

## directory corrente
cd $(dirname "$0")
cd $RL

## aggiornamento del sistema
apt-get update
apt-get upgrade -y

## informazioni
echo "lavoro su: $(pwd)"

## installazione di Apache
apt-get install -y apache2

## installazione di certbot
apt-get install -y python3-certbot-apache

## installazione di PHP
apt-get install -y php

## installazione di composer
apt-get install -y composer

## installazione degli strumenti di sviluppo
apt-get install -y php-dev

## installazione di PEAR
apt-get install -y php-pear

## installazione di CURL
apt-get install -y php-curl

## installazione di SSH
apt-get install -y php-ssh2

## installazione di GD
apt-get install -y php-gd

## installazione libreria per xml
apt-get install -y php-xml

## installazione libreria per yaml
apt-get install -y php-yaml

## installazione libreria Tidy
apt-get install -y php-tidy

## installazione di IMAP
apt-get install -y php-imap

## installazione di APCU
apt-get install -y php-apcu

## installazione di memcache
apt-get install -y memcached
apt-get install -y php-memcache
apt-get install -y php-memcached

## installazione di redis
apt-get install -y redis-server
apt-get install -y php-redis

## installazione di php-zip
apt-get install -y php-zip

## installazione di php-intl
apt-get install -y php-intl

## installazione di ncftp
# apt-get install -y ncftp

## installazione di mysql
# apt-get install -y default-mysql-server

## attivazione del modulo rewrite
a2enmod rewrite

## attivazione del modulo expires
a2enmod expires

## attivazione del modulo headers
a2enmod headers

## attivazione modulo mysqlnd
phpenmod mysqlnd

## attivazione modulo tidy
phpenmod tidy

## installazione di Pear FTP
# pear install Net_FTP

## installazione di adminer
# apt-get install -y adminer
# a2enconf adminer

## riavvio di Apache
service apache2 restart

## aggiorno composer
composer update

## permessi
_src/_sh/_lamp.permissions.secure.sh

## fine script
# echo "se necessario, riavviare la sessione o il computer per aggiornare i gruppi dell'utente corrente"
