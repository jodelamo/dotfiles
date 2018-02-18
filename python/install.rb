#!/usr/bin/env ruby

version = "3.8.1"
system("CFLAGS='-I$(xcrun --show-sdk-path)/usr/include' pyenv install #{version} --skip-existing")
system("pyenv global #{version}")
system("pyenv rehash")
system("pip install --upgrade pip")

installed = `pip list | awk 'FNR > 2 { print $1 }'`

packages = %w[
  neovim
  pynvim
]

packages.each do |p|
  system("pip install --user #{p}") unless installed.include? p
end
