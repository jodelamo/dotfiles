#!/bin/sh

version="1.26.1"

goenv install "$version" --skip-existing
goenv global "$version"
goenv rehash

packages="github.com/ericchiang/pup@latest"

for p in $packages; do
  go install "$p"
done
