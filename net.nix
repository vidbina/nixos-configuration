{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bind
    openfortivpn
    nmap
    telnet
    wireshark
  ];
}
