{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bind
    freerdp
    iftop
    ldns
    openfortivpn
    openssl
    openvpn
    netcat
    networkmanagerapplet
    nmap
    telnet
    tor
  ];

  programs = {
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
  };

  networking = {
    firewall.enable = true;

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    networkmanager = {
      enable = true;
      packages = with pkgs; [
        networkmanager_openvpn
      ];
      useDnsmasq = true;
    };
    # wireless.enable = wlp58s0;  # Enables wireless support via wpa_supplicant.
  };

  services = {
    dnsmasq = {
      enable = true;
      extraConfig = ''
        address=/.local/127.0.0.1
      '';
    };
    openssh = {
      enable = true;
      listenAddresses = [
        { addr = "127.0.0.1"; port = 22; }
      ];
      authorizedKeysFiles = [
        "/store/vidbina.home/.ssh/ssh_proxy.pub"
      ];
    };
    privoxy = {
      enable = true;
    };
  };

  security = {
    wrappers = {
      nethogs = {
        source = "${pkgs.nethogs.out}/bin/nethogs";
      };
    };
  };
}
