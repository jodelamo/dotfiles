#!/bin/sh

packages="tiktoken_core"

for p in $packages; do
  luarocks install "$p"
done
