#!/bin/bash -e
####
# based on http://www.clock.co.uk/blog/a-guide-on-how-to-cache-npm-install-with-docker
#
# Set's the last modified timestamp of a file to it's repositories commit timestamp. 
# 
# Particular useful with docker when building after a new git checkout has been made,
# can improve docker build times for composer, bower, npm, etc
#
# @see https://github.com/docker/docker/issues/3556
####

usage()
{
    echo "Usage: git-timestamp <file>"
    echo "Set a files last modified time to match it's git commit timestamp."
}

if test $# = 0; then
    usage
    exit
fi

FILE=$1

if [ ! -f $FILE ]; then
    echo "File not found!"
    exit
fi

REV=$(git rev-list -n 1 HEAD "$FILE");
STAMP=$(git show --pretty=format:%ai --abbrev-commit "$REV" | head -n 1);
touch -d "$STAMP" $FILE;

echo "Set $FILE to $STAMP"