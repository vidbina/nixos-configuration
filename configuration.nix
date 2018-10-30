# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

let
  newNixpkgs = builtins.fetchTarball { # 18.09
    url = "https://github.com/NixOS/nixpkgs/archive/06fb0253afabb8cc7dc85db742e2de94a4d68ca0.tar.gz";
    sha256 = "0jkldgvdm8pl9cfw5faw90n0qbbzrdssgwgbihk1by4xq66khf1b";
  };
  oldNixpkgs = builtins.fetchTarball { # vidbina's current (18.03)
    url = "https://github.com/NixOS/nixpkgs/archive/ba2a04f656d170306d587657359927acc9c51808.tar.gz";
    sha256 = "1nw2m7gz5s0qrj0vxl71w6ynl39rcqsdg8r3pcbmxdlkd1i9gjss";
  };
  pkgs = import oldNixpkgs { config = {}; };
  allPackages = with pkgs; [

    ./users.nix

    ./packages.nix

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
    ./temp.nix
    ./terminal.nix
    ./tron.nix      # tools for electronics engineering
    ./unity3d.nix
    ./virt.nix
    ./xmonad.nix
  ];

in { config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./base.nix
  ] ++ allPackages;
}
