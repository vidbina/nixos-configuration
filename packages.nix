{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    chromium
    curl
    darcs
    dmenu
    git
    gnupg
    rxvt_unicode
    okular
    st
    vim
    torbrowser
    wget
  ];
}
