{ config, pkgs ? (import ./nixpkgs.nix).default, ... }:

{
  environment.systemPackages = with pkgs; [
    cool-retro-term
    termite
  ];

  services.urxvtd.enable = true;

  programs = {
    bash = {
      enableCompletion = true;
    };
    zsh = let
      keybindings = ''
        # Note ^ or \C is Ctrl, \M is Alt
        bindkey '^ ' autosuggest-accept
        bindkey -M viins '\C-U' kill-whole-line # removes everything
        bindkey -M viins '\C-P' history-incremental-pattern-search-backward
        bindkey -M viins '\C-N' history-incremental-pattern-search-forward
      '';
    in {
      enable = true;
      autosuggestions = {
        enable = true;
      };
      interactiveShellInit = ''
        export EDITOR=nvim

        setopt histignorespace # keeps lines preceded with SPACE out of history
      '';
      promptInit = ''
        autoload -U promptinit && \
        promptinit && \
        prompt adam2 8bit yellow red blue

        # enable bash completion
        autoload -U +X bashcompinit && \
        bashcompinit

        bindkey -v # use vim key bindings
        ${keybindings}

        source ${pkgs.fzf}/share/fzf/completion.zsh
        source ${pkgs.fzf}/share/fzf/key-bindings.zsh

      '';
      syntaxHighlighting = {
        enable = true;
      };
    };
  };
}
