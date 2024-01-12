#!/usr/bin/env ruby

version = "20.11.0"

system("nodenv install #{version} --skip-existing")
system("nodenv global #{version}")
system("nodenv rehash")

installed = `npm ls -g -p --depth=0 | sed '1d' | sed 's@.*/@@'`

packages = %w[
  @fsouza/prettierd
  @volar/server
  neovim
  pure-prompt
  stylelint-lsp
  typescript
  typescript-language-server
  vls
  vscode-langservers-extracted
  yarn
]

packages.each do |p|
  system("npm install -g #{p}") unless installed.include? p
end
