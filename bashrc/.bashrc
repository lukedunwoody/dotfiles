#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Quick-start hyprland
alias hypl='start-hyprland'

# Flatpak apps
alias roblox='flatpak run org.vinegarhq.Sober'
alias upscayl='flatpak run org.upscayl.Upscayl'
alias budslink='flatpak run io.github.maniacx.BudsLink'

# AppImages
alias heroic="$HOME/Applications/Heroic-linux-x86_64.AppImage"
alias lunar="$HOME/Applications/Lunar-Client.AppImage"

PS1='[\u@\h \W]\$ '
export PATH="$HOME/.local/bin:$PATH"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
