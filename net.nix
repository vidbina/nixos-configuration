{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bind
    #freerdp
    #iftop
    #ipfs
    #ldns
    openssl
    openvpn
    netcat
    nmap
    #telnet
    #tor
  ];

  programs = {
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
  };

  networking = {
    enableIPv6 = false;

    firewall = {
      enable = true;

      allowPing = false;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };

    networkmanager = {
      enable = true;

      dns = "default";
      plugins = with pkgs; [ networkmanager-openvpn ];
    };

    wireless = {
      enable = false;
    };
  };

  services = {
    dnsmasq = {
      enable = false;
      extraConfig = ''
        address=/.local/127.0.0.1
      '';
      servers =
        let
          all = (provider: provider.ipv4 ++ provider.ipv6);
          cloudflare = {
            # https://1.1.1.1/dns/
            ipv4 = [ "1.1.1.1" "1.0.0.1" ];
            ipv6 = [ "2606:4700:4700::1111" "2606:4700:4700::1001" ];
          };
          ethservices-ns31 = {
            # https://servers.opennicproject.org/edit.php?srv=ns31.de.dns.opennic.glue
            ipv4 = [ "195.10.195.195" ];
            ipv6 = [ "2a00:f826:8:2::195" ];
          };
          quad9-primary = {
            # https://www.quad9.net/faq/#Does_Quad9_implement_DNSSEC
            ipv4 = [ "9.9.9.9" "149.112.112.112" ];
            ipv6 = [ "2620:fe::fe" "2620:fe::9" ];
          };
          quad9-edns = {
            # https://www.quad9.net/faq/#What_is_EDNS_Client-Subnet
            ipv4 = [ "9.9.9.11" "149.112.112.11" ];
            ipv6 = [ "2620:fe::11" "2620:fe::fe:11" ];
          };
        in
        builtins.foldl' (acc: val: acc ++ val.ipv4) [ ] [
          cloudflare
          ethservices-ns31
          quad9-edns
        ];
    };

    # TODO: Remove dep on untracked config dir
    #openvpn =
    #  let
    #    describeConnection =
    #      { handle
    #      , configFile
    #      , passFile
    #      , autoStart ? false
    #      , updateResolvConf ? true
    #      , additionalConfig ? ""
    #      ,
    #      }: {
    #        "${handle}" = {
    #          autoStart = autoStart;
    #          updateResolvConf = updateResolvConf;
    #          config = ''
    #            config ${configFile}
    #            auth-user-pass ${passFile}
    #            ${additionalConfig}
    #          '';
    #        };
    #      };
    #  in
    #  {
    #    servers = builtins.foldl'
    #      (acc: val: acc // describeConnection (val))
    #      { }
    #      (
    #        import ./config/openvpn.nix {
    #          toUpper = pkgs.lib.toUpper;
    #        }
    #      );
    #  };

    openssh = {
      enable = false;
      listenAddresses = [
        { addr = "127.0.0.1"; port = 22; }
      ];
      authorizedKeysFiles = [
        # "/store/vidbina.home/.ssh/ssh_proxy.pub"
      ];
    };

    privoxy = {
      enable = true;
    };
  };
}
