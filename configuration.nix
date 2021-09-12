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

    # basics
    ./dev.nix
    ./emacs.nix
    ./vim.nix
    ./fonts.nix
    ./interfacing.nix
    ./terminal.nix
    ./net.nix

    # X
    ./x.nix
    ./xmonad.nix

    # other
    ./audio.nix
    ./browser.nix
    ./cad.nix # CAD tools (mostly 3d)
    ./chat.nix
    ./crypto.nix
    ./doc.nix
    #./eid.nix       # eID packages
    ./games.nix
    ./graphic.nix # tools for graphics editing and design
    ##./i3.nix
    ./mail.nix
    ./math.nix
    ./media.nix
    ./productivity.nix
    ./sec.nix
    #./temp.nix
    ./tron.nix # tools for electronics engineering
    #./unity3d.nix
    ./virt.nix
  ];
}
