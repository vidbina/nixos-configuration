{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fortisslvpn
    nmap
    wireshark
  ];
}
