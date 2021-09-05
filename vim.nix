{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    configure = {
      packages.myVimPackage = {
        start = with pkgs.vimPlugins; [
          gitgutter
          tagbar
          nerdtree

          # async syntax checker w/ LSP support
          # https://github.com/dense-analysis/ale
          ale

          # languages
          vim-nix
          ## doc
          plantuml-syntax
          vim-markdown
          ## infra
          vim-terraform
          ## web
          vim-javascript
          vim-jsx-pretty
          typescript-vim
        ];
      };
    };
    viAlias = true;
    vimAlias = true;
    withRuby = true;
  };
}
