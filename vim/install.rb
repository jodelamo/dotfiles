#!/usr/bin/env ruby

require "fileutils"

# Install paq-nvim
system("git clone --depth=1 https://github.com/savq/paq-nvim.git \"${XDG_DATA_HOME:-$HOME/.local/share}\"/nvim/site/pack/paqs/start/paq-nvim")

config_dir = FileUtils.mkdir_p("#{Dir.home}/.config/nvim")
src_file = File.join(__dir__, "init.lua")
dest_file = File.join(config_dir, "init.lua")
FileUtils.ln_s(src_file, dest_file)
