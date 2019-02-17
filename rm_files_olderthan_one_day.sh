#!/bin/bash

find /var/www/html/downloads -type f -mtime +1 -exec rm {} \;
