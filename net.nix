{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nmap
    wireshark
  ];
}
