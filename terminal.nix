{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
    cool-retro-term
    kitty
    rxvt_unicode.terminfo
    st
    terminator
    termite
    dynamic-colors
  ];

  programs = {
    bash = {
      enableCompletion = true;
    };
    zsh = {
      enable = true;
      autosuggestions = {
        enable = true;
      };
      shellInit = ''
      '';
      interactiveShellInit = ''
        export EDITOR=nvim
        export VISUAL="emacsclient -c -a emacs"

        setopt histignorespace # keeps lines preceded with SPACE out of history

        zmodload -i zsh/complist
        source ${./zsh/zstyle.zsh}

        autoload -U promptinit && \
        promptinit && \
        prompt adam2 8bit yellow red blue

        # enable bash completion
        autoload -U +X bashcompinit && \
        bashcompinit
      '';
      promptInit = ''
        bindkey -v # use vim key bindings
        source ${./zsh/keybindings.zsh}

        source ${pkgs.fzf}/share/fzf/completion.zsh
        source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      '';
      syntaxHighlighting = {
        enable = true;
      };
    };
  };
}
