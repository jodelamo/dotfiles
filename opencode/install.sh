#!/bin/sh

if ! command -v opencode > /dev/null 2>&1; then
  curl -fsSL https://opencode.ai/v2/install | bash
fi
