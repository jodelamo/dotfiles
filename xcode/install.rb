#!/usr/bin/env ruby

installed = system("xcode-select --print-path > /dev/null 2>&1")

system("xcode-select --install > /dev/null 2>&1") unless installed

# Themes
target_directory = File.join(__dir__, "xcode-themes")
success = system("git clone git@github.com:hdoria/xcode-themes.git #{target_directory}")

if success
  system("cd #{target_directory} && ./install.sh")
  system("rm -rf #{target_directory}")
end
