# Update npm packages to latest version available
nug () {
  for package in $(npm -g outdated --parseable --depth=0 | cut -d: -f2)
  do
      npm -g install "$package"
  done
}
