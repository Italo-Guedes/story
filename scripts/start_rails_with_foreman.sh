#! /bin/sh



rm -rf /rdmapps/public/packs

bundle check || bundle install --jobs 20 --retry 5
yarn

bin/dev