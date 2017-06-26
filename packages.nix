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
    ghc
    git
    git-lfs
    gnome3.eog
    gnumake
    gnupg21
    mc
    mitscheme
    neovim
    oh-my-zsh
    pass
    pstree
    rstudio
    screenfetch
    st
    tmux
    torbrowser
    tree # pkgs/tools/system/tree
    w3m
    wget
    whois
    xclip
    xorg.xev
    xorg.xhost
    xorg.xmodmap
  ];
}
