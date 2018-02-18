#!/usr/bin/env ruby

require "fileutils"

dest = "~/.tmux/plugins/tpm"
FileUtils.mkdir_p dest
installed = File.directory?(File.expand_path(dest))

system("git clone https://github.com/tmux-plugins/tpm #{dest}") unless installed
