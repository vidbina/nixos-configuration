{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (import ./emacs.nix { inherit pkgs; })
    asciinema
    bazaar
    cmakeCurses
    darcs
    # deno # WIP
    gdb
    ghc
    git
    git-lfs
    glibc
    gnumake
    go
    httpie
    #htmlTidy
    jq
    #mitscheme
    neovim
    #stdenv
    sqlite_3_30_1
    subversion
    xxd
  ];

  nixpkgs.config = {};
}
