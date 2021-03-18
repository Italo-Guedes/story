#!/bin/sh
docker volume rm $(docker volume ls -q | egrep -v "_database" | egrep -v "_cache")