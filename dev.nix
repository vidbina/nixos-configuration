{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # deno # WIP
    #htmlTidy
    #mitscheme
    #stdenv
    (import ./emacs.nix { inherit pkgs; })
    asciinema
    bazaar
    cmakeCurses
    darcs
    gdb
    ghc
    git
    git-lfs
    glibc
    gnumake
    go
    haskellPackages.hlint
    httpie
    jq
    neovim
    sqlite_3_30_1
    subversion
    xxd
  ];

  nixpkgs.config = {};
}
