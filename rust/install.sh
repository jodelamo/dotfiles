#!/bin/sh

if ! command -v rustup > /dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
else
  rustup update
fi

packages="tree-sitter-cli"

for p in $packages; do
  cargo install "$p"
done
