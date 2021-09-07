{ pkgs, ... }:
let
  vim-dim = pkgs.vimUtils.buildVimPlugin {
    name = "vim-dim";
    src = pkgs.fetchFromGitHub {
      owner = "jeffkreeftmeijer";
      repo = "vim-dim";
      rev = "8320a40f12cf89295afc4f13eb10159f29c43777";
      sha256 = "sha256-sDt3gvf+/8OQ0e0W6+IinONQZ9HiUKTbr+RZ2CfJ3FY";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    configure = {
      customRC = ''
        colorscheme dim
      '';
      packages.myVimPackage = {
        start = with pkgs.vimPlugins; [
          gitgutter
          tagbar
          nerdtree
          vim-dim

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
