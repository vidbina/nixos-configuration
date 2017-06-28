{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    apvlv
    arandr
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
    pciutils
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
