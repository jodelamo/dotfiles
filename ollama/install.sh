#!/bin/sh

if ! command -v ollama > /dev/null 2>&1; then
  curl -fsSL https://ollama.com/install.sh | sh
fi
