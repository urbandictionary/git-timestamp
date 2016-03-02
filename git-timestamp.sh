#!/bin/bash -e
####
# based on http://www.clock.co.uk/blog/a-guide-on-how-to-cache-npm-install-with-docker
#
# Set's the last modified timestamp of a file to it's repositories commit timestamp. 
# 
# Particularly useful with docker when building after a new git checkout has been made,
# can improve docker build times for composer, bower, npm, etc
#
# @see https://github.com/docker/docker/issues/3556
####

set -e

if test $# = 0; then
  echo "Usage: git-timestamp <files>"
  echo "Set the files' last modified times to match their git commit timestamps."
  exit
fi

for FILE in "$@"
do
  REV=$(git rev-list -n 1 HEAD "$FILE");
  STAMP=$(git log -1 --pretty=format:%ct "$REV")
  touch -d @"$STAMP" "$FILE"

  echo "Set $FILE to $STAMP"
done