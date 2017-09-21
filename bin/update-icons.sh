#!/bin/bash

# Installs new icons to src/AppBundle/Resources/views/_icons.
# These icons should be committed to the git repository. Old icons are not
# removed.

set -e

PROJECT_ROOT=$(dirname $(dirname $(realpath $0)))
PATH="$PROJECT_ROOT/node_modules/.bin:$PATH"
TEMP=$(mktemp -d)
OUT="$PROJECT_ROOT/src/AppBundle/Resources/views/_icons"

trap 'rm -rf "$TEMP"' EXIT

fontello-cli install --config "$PROJECT_ROOT/fontello.json" --font "$TEMP" --css "$TEMP"
font-blast "$TEMP/raddit.svg" "$TEMP"
perl -pi -e's/^(<svg) ?/$1 width="16" height="16" /' "$TEMP/svg/"*.svg
mv "$TEMP/svg/"*.svg "$OUT"
