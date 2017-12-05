{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bind
    freerdp
    openfortivpn
    openssl
    openvpn
    netcat
    nmap
    telnet
    wireshark
  ];
}
