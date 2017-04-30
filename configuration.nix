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
    synaptics = {
      enable = true;
      horizEdgeScroll = false;
      palmDetect = true;
      twoFingerScroll = true;
      vertEdgeScroll = false;
    };
    windowManager = {
      default = "i3";
      i3 = {
        enable = true;
      };
    };
  };
}
