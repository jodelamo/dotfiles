#!/usr/bin/env ruby

exists = `command -v brew > /dev/null 2>&1`

unless exists
  pid = Kernel.fork do
    system("/usr/bin/ruby -e '$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)'")
  end

  Process.wait(pid)

  system("brew bundle")
end
