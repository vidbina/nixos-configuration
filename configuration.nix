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

    ./utils.nix

    ./audio.nix
    ./browser.nix
    ./cad.nix       # CAD tools (mostly 3d)
    ./chat.nix
    ./crypto.nix
    ./dev.nix
    ./dev.nix
    ./doc.nix
    ./docker.nix
    ./eid.nix       # eID packages
    ./fonts.nix
    ./games.nix
    ./graphic.nix   # tools for graphics editing and design
    #./i3.nix
    ./interfacing.nix
    ./mail.nix
    ./math.nix
    ./media.nix
    ./net.nix
    ./productivity.nix
    ./sec.nix
    ./temp.nix
    ./terminal.nix
    ./tron.nix      # tools for electronics engineering
    ./unity3d.nix
    ./virt.nix
    ./xmonad.nix
  ];
}
