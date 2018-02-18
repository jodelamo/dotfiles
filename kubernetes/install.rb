#!/usr/bin/env ruby

filePath = "#{__dir__}/fubectl.zsh"

system("curl -L https://rawgit.com/kubermatic/fubectl/master/fubectl.source > #{filePath}")
system("source #{filePath}")
