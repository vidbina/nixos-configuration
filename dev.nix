{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (import ./emacs.nix { inherit pkgs; })
    #asciinema
    #bazaar
    cmakeCurses
    #darcs
    gdb
    #ghc
    git
    git-lfs
    glibc
    gnumake
    go
    #htmlTidy
    #jq
    #mitscheme
    neovim
    #stdenv
    xxd
  ];

  nixpkgs.config = {
  };
}
