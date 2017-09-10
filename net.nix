{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bind
    freerdp
    openfortivpn
    nmap
    telnet
    wireshark
  ];
}
