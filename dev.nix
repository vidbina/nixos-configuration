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
    httpie
    jq
    neovim
    shfmt
    sqlite_3_31_1
    subversion
    xxd
  ] ++ (with haskellPackages; [
    #hfmt # broken
    hindent
    hlint
    stylish-haskell
  ]);

  nixpkgs.config = {};
}
