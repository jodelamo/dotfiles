require "fileutils"

desc "Create symlinks"
task :bootstrap do
  dotfiles_root = File.join(__dir__)

  # macOS setup
  system("#{dotfiles_root}/bin/macos") if RUBY_PLATFORM.include? "darwin"

  # Symlink everything ending with ".symlink"
  symlinks = Dir.glob(File.join(dotfiles_root, "*/*.symlink"))

  # Create symbolic links
  symlinks.each do |source|
    # Remove ".symlink" suffix
    target = "#{Dir.home}/.#{File.basename(source, '.*')}"

    unless File.exist?(target)
      puts("Symlink: #{source} -> #{target}")
      FileUtils.ln_s(source, target, force: true)
    end
  end
end

desc "Install packages"
task :install do
  installers = Dir.glob(File.join(__dir__, "*/install.rb"))

  # Run installation files one directory level down
  installers.each do |f|
    installer = File.expand_path(f)
    puts("Install: #{installer}")
    system(installer)
  end
end
