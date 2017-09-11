{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bind
    freerdp
    openfortivpn
    openvpn
    nmap
    telnet
    wireshark
  ];
}
