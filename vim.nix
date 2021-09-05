{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (neovim.override {
      configure = {
        packages.myVimPackage = {
          start = with vimPlugins; [
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
            elm-syntax
            vim-javascript
            vim-jsx-pretty
            typescript-vim
          ];
        };
      };
      viAlias = true;
    })
  ];
}
