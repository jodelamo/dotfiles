#!/usr/bin/env ruby

version = "1.19.0"

system("goenv install #{version} --skip-existing")
system("goenv global #{version}")
system("goenv rehash")

packages = %w[
  github.com/abenz1267/gomvp@latest
  github.com/ericchiang/pup@latest
  golang.org/x/vuln/cmd/govulncheck@latest
]

packages.each do |p|
  system("go install #{p}")
end
