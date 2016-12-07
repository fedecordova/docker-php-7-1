# LAMP docker container with php 7

Features
* xdebug

## Install

    docker pull danielsamson/docker-php-7

## First run
    docker run -d -P --name php-7 -v /var/www/html/:/var/www/html/ danielsamson/docker-php-7

you may wish to change the volume in order to mount the current working directory to /var/www/html
    
    docker run -d -P --name php-7 -v $(pwd):/var/www/html/ danielsamson/docker-php-7

## Start the container

    docker start php-7

## Open a bash shell

    docker exec -it php-7 bash
   
# Common issues

You may have to open a shell and restart mysql and apache if they are not running.

This image assumes you are using ubuntu with the docker0 interface. So that you can access the images via 172.16.0.2-172.16.0.254.
