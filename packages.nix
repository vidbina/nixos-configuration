{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chromium
    conky
    curl
    darcs
    dmenu
    dzen2
    git
    git-lfs
    gnome3.eog
    gnumake
    gnupg21
    inkscape
    kicad
    mc
    neovim
    oh-my-zsh
    okular
    pass
    pstree
    rstudio
    st
    tmux
    torbrowser
    tree # pkgs/tools/system/tree
    w3m
    wget
    xclip
    xorg.xev
    xorg.xmodmap
  ];
}
