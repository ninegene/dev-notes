#!/bin/bash
set -e

git push origin master

# ssh-ng is local alias to ssh into web server
ssh-ng "/var/www/dev-notes.ninegene.com/dev-notes/dist.sh"

