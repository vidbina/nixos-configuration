{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chromium
    firefox
    qutebrowser
    # (
    #   qutebrowser.overrideAttrs (
    #     oldAttrs: rec {
    #       propagatedBuildInputs = [ oldAttrs.propagatedBuildInputs ] /*++ (
    #         with python3Packages; [ pyflakes pycodestyle ]
    #       )*/;
    #     }
    #   )
    # )
  ];

  nixpkgs.config.firefox = {
    enableEsteid = true;
  };
}
