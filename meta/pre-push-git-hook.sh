#!/usr/bin/env bash

# Move me to .git/hooks/pre-push

set -e

project_dir=$(git rev-parse --show-toplevel)
site_dir=${project_dir}"/_site"
remote_dir="exocortex.anothernode.com:~/exocortex"

cd ${project_dir}
bundle exec jekyll build

echo "-----------------------------------------"
echo " 🛠  Site successfully built with Jekyll "
echo "-----------------------------------------"

rsync --recursive ${site_dir}/* ${remote_dir}

echo "-------------------------------------"
echo " 🏗  Exocortex successfully deployed "
echo "-------------------------------------"
