#!/bin/bash
set -e

git push origin master

# "dev-notes" is configured in ~/.ssh/config
ssh dev-notes "
cd /var/www/dev-notes.ninegene.com/dev-notes;
git pull origin master;
./dist.sh
"
