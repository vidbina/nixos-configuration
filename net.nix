{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    networkmanager_fortisslvpn
    nmap
    wireshark
  ];
}
