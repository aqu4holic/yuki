# Find nerd fonts
search nerd font using this
https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts
get the one u want, get the name after the url

# Things to do
fastfetch
rofi
dunst

# purging
```nix
nix-collect-garbage  --delete-old

sudo nix-collect-garbage -d

sudo /run/current-system/bin/switch-to-configuration boot
```