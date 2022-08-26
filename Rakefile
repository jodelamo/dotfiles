desc "Create symlinks"
task :bootstrap do
  require "fileutils"

  home_dir = Dir.home

  dotfiles_root = File.join(__dir__)
  symlinks = Dir.glob(File.join(dotfiles_root, "*/*.symlink"))

  # Create symbolic link from .symlink file/directory to $HOME, sans extension
  symlinks.each do |source|
    target = "#{home_dir}/.#{File.basename(source, '.*')}"

    unless File.exist?(target)
      puts "Symlink: #{source} -> #{target}"
      FileUtils.ln_s(source, target, force: true)
    end
  end

  # macOS setup
  system("#{dotfiles_root}/bin/macos") if RUBY_PLATFORM.include? "darwin"
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
      puts "Install: #{installer}"
      system(installer)
    end
  end
end
