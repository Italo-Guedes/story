#!/bin/sh
docker run --rm -v `basename "$PWD"`_database:/volume debian:jessie tar -xzvf /backup/backup.tar.gz "${@:2}"
