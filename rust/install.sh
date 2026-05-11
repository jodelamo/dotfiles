#!/bin/sh

version="1.95.0"

if ! command -v rustup > /dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
else
  rustup update
fi

rustup toolchain install "$version"
rustup default "$version"

packages="tree-sitter-cli"

for p in $packages; do
  cargo install "$p"
done
