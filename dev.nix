{ config, pkgs, ... }:
let
  neovim-vidbina = with pkgs; neovim.override {
    viAlias = true;
    #withNodeJs = true;
  };

  sqlite-interactive = (pkgs.sqlite.override {
    interactive = true;
  });
in
{
  environment.systemPackages = with pkgs; [
    asciinema
    checkmake
    cmakeCurses
    gdb
    ghc
    ghcid
    ghidra-bin
    gitAndTools.gitFull # to include send-email
    git-lfs
    github-cli
    glibc
    gnumake
    go
    hexyl
    html-tidy
    htmlTidy
    httpie
    httplab # interactive web server
    jq # pretty-print JSON
    kakoune
    mitscheme
    neovim-vidbina
    nodejs
    rnix-lsp # LSP
    shellcheck
    shfmt
    sqlite-interactive
    subversion
    wuzz # cURL-like TUI HTTP request inspection tool
    xxd
    yq # pretty-print YAML
  ]
  ++ (
    with haskellPackages; [
      apply-refact # for hlint --refactor
      hlint
      hscolour
      stylish-haskell
    ]
  )
  ++ (
    with pythonPackages; [
    ]
  )
  ;
}
