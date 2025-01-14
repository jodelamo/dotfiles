#!/usr/bin/env ruby

ruby_version = "3.4.1"

system("rbenv install #{ruby_version} --skip-existing")
system("rbenv global #{ruby_version}")
system("rbenv rehash")

installed = `gem list | awk '{ print $1 }'`

gems = %w[
  bundler
  neovim
  rouge
  rubocop
]

gems.each do |p|
  system("gem install #{p}") unless installed.include? p
end
