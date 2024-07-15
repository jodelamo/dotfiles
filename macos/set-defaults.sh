#!/bin/sh

# Put screenshots somewhere other than the desktop
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location ~/Screenshots

# Disable shadows in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Enable AirDrop over Ethernet and on Unsupported Macs
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Always open everything in Finder's list view.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show the ~/Library folder.
chflags nohidden ~/Library

# Set a really fast key repeat.
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 1

# Set the Finder prefs for showing a few different volumes on the Desktop.
defaults write com.apple.Finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.Finder ShowRemovableMediaOnDesktop -bool true

# Reset LaunchPad, because it's always a mess anyway. This will put bundled
# apps on the first page, and all other installed apps on the following pages,
# sorted alphabetically.
defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock
