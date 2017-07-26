{ config, pkgs, ... }:

{
  nixpkgs.config.firefox.enableEsteid = true;

  environment.systemPackages = with pkgs; [
    (import ./eid/qesteidutil.nix) #vid-qesteidutil
  ];

  services.pcscd = {
    enable = true;
  };
}

