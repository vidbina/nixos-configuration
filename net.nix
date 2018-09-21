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
      insertNameservers = [
        "127.0.0.1"
      ];
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
      servers = [
        "185.208.208.141" # ns1.nl.dns.opennic.glue (Sponsored by mon0.li)
        "82.196.9.45"     # ns1.nh.nl.dns.opennic.glue
        "146.185.176.36"  # ns7.nh.nl.dns.opennic.glue (Sponsored by phillymesh.net)
        "51.15.98.97"     # ns12.nh.nl.dns.opennic.glue

        "94.247.43.254"   # ns8.he.de.dns.opennic.glue (Sponsored by ETH-Services)
        "130.255.78.223"  # ns22.de.dns.opennic.glue (Sponsored by edv-froehlich.de)
        "94.16.114.254"   # ns11.de.dns.opennic.glue
        "46.101.70.183"   # ns9.de.dns.opennic.glue (Sponsored by hollweck.it)
        "50.3.82.215"     # ns7.de.dns.opennic.glue (Sponsored by edv-froehlich.de)
        "82.141.39.32"    # ns1.de.dns.opennic.glue (Sponsored by edv-froehlich.de)

        "139.59.18.213"   # ns1.ka.in.dns.opennic.glue
        "163.53.248.170"  # ns2.vic.au.dns.opennic.glue
        "91.217.137.37"   # ns5.ru.dns.opennic.glue (Sponsored by subnets.ru)
      ];
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
