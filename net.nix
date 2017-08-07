{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openfortivpn
    nmap
    telnet
    wireshark
  ];
}
