#!/usr/bin/env ruby

exists = system("command -v brew", out: File::NULL)

unless exists
  puts "Installing Homebrew..."
  pid = Kernel.fork do
    system({ "NONINTERACTIVE" => "1" }, "curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh",
           out: File::NULL)
  end

  Process.wait(pid)
end

puts "Installing dependencies from Brewfile..."
system("brew bundle --file=#{Dir.pwd}/Brewfile")
