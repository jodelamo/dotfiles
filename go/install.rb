#!/usr/bin/env ruby

version = "1.19.0"

system("goenv install #{version} --skip-existing")
system("goenv global #{version}")
system("goenv rehash")

packages = %w[
  github.com/ericchiang/pup
  golang.org/x/tools/cmd/goimports
  golang.org/x/tools/gopls@latest
  mvdan.cc/sh/v3/cmd/shfmt@latest
]

packages.each do |p|
  system("go install #{p}")
end
