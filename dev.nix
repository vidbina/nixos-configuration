{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
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
    jq
    mitscheme
    neovim
    stdenv
    xxd
  ];

  nixpkgs.config = {
  };
}
