desc "Create symlinks"
task :bootstrap do
  require "fileutils"

  HOME = ENV["HOME"]

  dotfiles_root = File.join(__dir__)
  symlinks = Dir.glob(File.join(dotfiles_root, "*/*.symlink"))

  # Create symbolic link from .symlink directory to $HOME, sans extension
  symlinks.each do |source|
    dest = ENV["HOME"] + "/." + File.basename(source, ".*")
    puts "==> Symlink: #{source} => #{dest}"
    FileUtils.ln_s(source, dest, force: true)
  end

  # macOS setup
  system("#{dotfiles_root}/bin/dot") if RUBY_PLATFORM.include? "darwin"
end

desc "Install packages"
task :install do
  here = File.expand_path(__FILE__)
  installers = Dir.glob(File.join(__dir__, "*/install.rb"))

  # Run installation files one directory level down
  installers.each do |f|
    installer = File.expand_path(f)

    # Skip this installer to avoid opening a black hole of death
    unless installer.eql? here
      puts "==> Install: #{installer}"
      system(installer)
    end
  end
end
