#!/usr/bin/env ruby

require "fileutils"

# rubocop:disable Layout/LineLength
# Install packer.nvim
system("git clone --depth=1 https://github.com/wbthomason/packer.nvim \"${XDG_DATA_HOME:-$HOME/.local/share}\"/nvim/site/pack/packer/start/packer.nvim")
# rubocop:enable Layout/LineLength

config_dir = FileUtils.mkdir_p("#{Dir.home}/.config/nvim")
src_file = File.join(__dir__, "init.lua")
dest_file = File.join(config_dir, "init.lua")

FileUtils.ln_s(src_file, dest_file) unless File.exist?(dest_file)
