# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./base.nix
    ];

  # Enable the X11 windowing system.
  services.xserver = {
    libinput = {
      clickMethod = "clickfinger";
      scrollMethod = "twofinger"; # mimick Macbook behavior
      sendEventsMode = "disabled"; # ingore if external pointing dev is connected
      tapping = false; # mimick Macbook behavior
      enable = true;
    };

    # NOTE: Set XMonad as wm again. Make sure to set .xmonad/xmonad.hs
    windowManager = {
      default = "xmonad";
      xmonad = {
        enableContribAndExtras = true;
        enable = true;
      };
    };
  };
}
