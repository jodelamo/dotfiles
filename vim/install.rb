#!/usr/bin/env ruby

# rubocop:disable Layout/LineLength
# Install packer.nvim
system("git clone --depth=1 https://github.com/wbthomason/packer.nvim \"${XDG_DATA_HOME:-$HOME/.local/share}\"/nvim/site/pack/packer/start/packer.nvim")
# rubocop:enable Layout/LineLength
