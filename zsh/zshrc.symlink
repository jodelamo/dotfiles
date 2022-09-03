# Keep secrets in `.localrc`
if [[ -a ~/.localrc ]] then
  source ~/.localrc
fi

# Shortcut to this dotfiles path is $ZSH
export ZSH=~/.dotfiles

# Your project folder that we can `c [tab]` to
export PROJECTS=~/Dev

# Initialize autocomplete here, otherwise functions won't be loaded
autoload -Uz compinit; compinit
zmodload -i zsh/complist

# A better `mv`
autoload -U zmv

# All of our zsh files
typeset -U config_files
config_files=($ZSH/**/*.zsh)

# Load the path files
for file in ${(M)config_files:#*/path.zsh}; do
  source $file
done

# Load everything but the path and completion files
for file in ${${config_files:#*/path.zsh}:#*/completion.zsh}; do
  source $file
done

# Load every completion after autocomplete loads
for file in ${(M)config_files:#*/completion.zsh}; do
  source $file
done

unset config_files

# Enable zsh syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
