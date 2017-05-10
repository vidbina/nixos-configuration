# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./base.nix
      ./packages.nix
      ./users.nix
      # TODO: figure out how to make the following configurable
      # Was thinking about loading a WM env var and then determine which
      # element to import from that
      # Looked into:
      #  - Maybe https://hackage.haskell.org/package/base-4.9.1.0/docs/Data-Maybe.html
      #  - list comprehensions seem too involved
      #  - pattern matching
      ./xmonad.nix
    #  ./i3.nix
      ./interfacing.nix
      ./temp.nix
    ];
}
