#!/bin/sh

version="1.26.4"

goenv install "$version" --skip-existing
goenv use "$version" --global
goenv rehash

packages="github.com/ericchiang/pup@latest"

for p in $packages; do
  go install "$p"
done
