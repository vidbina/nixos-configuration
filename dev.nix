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
    gitAndTools.ghorg
    git
    git-lfs
    github-cli
    glibc
    gnumake
    go
    html-tidy
    httpie
    jq
    k9s
    neovim
    shfmt
    shfmt
    sqlite_3_31_1
    subversion
    xxd
    yq
  ]
  ++
  (with haskellPackages; [
    #hfmt # broken, see ~/.config/nixpkgs/config.nix
    #hadolint # broken, see ~/.config/nixpkgs/config.nix
    apply-refact # for hlint --refactor
    hindent
    hlint
    stylish-haskell
  ])
  ++
  (with pythonPackages; [
    yamllint
  ])
  ;

  nixpkgs.config = {};
}
