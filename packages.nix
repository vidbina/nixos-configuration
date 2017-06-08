{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    apvlv
    chromium
    conky
    curl
    darcs
    dmenu
    dzen2
    file
    git
    git-lfs
    gnome3.eog
    gnumake
    gnupg21
    mc
    neovim
    oh-my-zsh
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
    xorg.xhost
    xorg.xmodmap
  ];
}
