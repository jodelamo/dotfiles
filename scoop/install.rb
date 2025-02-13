#!/usr/bin/env ruby

config_file = "scoopfile.txt"

system("Get-Content #{config_file} | ForEach-Object { scoop install $_ }")
