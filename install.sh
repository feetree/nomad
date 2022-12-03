#!/bin/bash
chmod o-r /
apt update && apt upgrade --yes
apt install htop mc nginx
apt install php8.1-fpm php8.1-mbstring php8.1-json php8.1-zip