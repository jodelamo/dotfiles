require "fileutils"
require "yaml"

# Constants
LINK = "link".freeze

desc "Bootstrap"
task :bootstrap do
  # macOS setup
  dotfiles_root = File.join(__dir__)
  system("#{dotfiles_root}/bin/macos") if RUBY_PLATFORM.include? "darwin"

  # Load config
  config = YAML.load_file("config.yml")

  config[LINK].each do |dest, source|
    puts("Symlink: #{source} -> #{dest}")
    # Create directories wherever necessary
    FileUtils.mkdir_p(File.expand_path(File.dirname(dest)))
    # Create symlinks
    FileUtils.ln_s(File.expand_path(source), File.expand_path(dest), force: true)
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
