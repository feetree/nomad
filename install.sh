#!/bin/bash
chmod o-r /
apt update && apt upgrade --yes
apt install htop mc nginx --yes
apt install php8.1-fpm php8.1-mbstring php8.1-dom php8.1-zip php8.1-simplexml php8.1-xml php8.1-gd php8.1-curl --yes