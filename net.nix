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

  networking = {
    firewall.enable = true;

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    networkmanager.enable = true;
    # wireless.enable = wlp58s0;  # Enables wireless support via wpa_supplicant.
  };
}
