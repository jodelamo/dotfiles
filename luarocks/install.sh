#!/usr/bin/env zsh

local -a packages=(
  "tiktoken_core"
)

for p in "$packages"; do
  luarocks install "$p"
done
