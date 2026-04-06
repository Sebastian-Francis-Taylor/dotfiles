#!/usr/bin/env bash
set -euo pipefail

TEMPLATE_DIR="${NOTES_TEMPLATE_DIR:-$HOME/.config/notes-template}"

usage() {
  echo "Usage: notes-template -name 'Course Name'"
  exit 1
}

NAME=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    -name) NAME="$2"; shift 2 ;;
    *) usage ;;
  esac
done

[[ -z "$NAME" ]] && usage

if [[ ! -d "$TEMPLATE_DIR" ]]; then
  echo "Error: template directory '$TEMPLATE_DIR' not found" >&2
  echo "Create it or set NOTES_TEMPLATE_DIR" >&2
  exit 1
fi

# Directory name: lowercase, spaces → hyphens
DIR="$(echo "$NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"

if [[ -d "$DIR" ]]; then
  echo "Error: directory '$DIR' already exists" >&2
  exit 1
fi

# Copy template tree
cp -r "$TEMPLATE_DIR" "$DIR"

# Substitute placeholders in main.typ
DATE="$(date +'%B %Y')"
sed -i "s/{{NAME}}/$NAME/g; s/{{DATE}}/$DATE/g" "$DIR/main.typ"

echo "Created project in ./$DIR/"
find "$DIR" -type f | sort | sed 's/^/  /'
