{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openfortivpn
    nmap
    wireshark
  ];
}
