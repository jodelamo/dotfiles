ru() {
  local outdated=$(gem outdated | cut -d ' ' -f 1 | tr '\n' ' ')
  gem update $outdated
}
