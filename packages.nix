{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    chromium
    # perhaps I need a namesake's named nix file for each package
    conky.override {
      luaSupport = true;
      wirelessSupport = true;
    }
    curl
    darcs
    dmenu
    dzen2
    git
    gnome3.eog
    gnupg
    luaPackages
    okular
    rxvt_unicode
    st
    torbrowser
    vim
    wget
    xorg.xev
    xorg.xmodmap
  ];
}
