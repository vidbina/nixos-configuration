{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    apvlv
    arandr
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
    hardinfo
    mc
    mitscheme
    neovim
    oh-my-zsh
    pass
    pciutils
    pmtools
    pstree
    screenfetch
    scrot
    st
    tcpdump
    tmux
    torbrowser
    tree # pkgs/tools/system/tree
    unzip
    usbutils
    w3m
    wget
    whois
    xclip
    xlockmore
    xorg.xev
    xorg.xhost
    xorg.xmodmap
  ];
}
