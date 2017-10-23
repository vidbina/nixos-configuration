{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bind
    freerdp
    openfortivpn
    openssl
    openvpn
    nmap
    telnet
    wireshark
  ];
}
