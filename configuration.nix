# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./base.nix
    ./users.nix

    ./eid.nix       # eID packages

    ./packages.nix
    ./browser.nix

    ./audio.nix
    ./math.nix
    ./cad.nix       # CAD tools (mostly 3d)
    ./dev.nix
    ./doc.nix
    ./fonts.nix
    ./docker.nix
    ./virtualbox.nix
    ./games.nix
    ./media.nix
    ./graphic.nix   # tools for graphics editing and design
    ./chat.nix
    ./mail.nix
    ./productivity.nix
    ./net.nix
    ./tron.nix      # tools for electronics engineering
    ./unity3d.nix

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
    ./urxvt.nix

    ./dev.nix
  ];
}
