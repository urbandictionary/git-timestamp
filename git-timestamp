#!/bin/sh
set -e

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