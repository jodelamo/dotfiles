fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)

# Enable custom prompt themes
autoload -U promptinit; promptinit

prompt pure
