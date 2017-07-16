{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (virtualbox.override {
      enableExtensionPack = true;
    })
  ];

  virtualisation.virtualbox.host.enable = true;

  nixpkgs.config.virtualbox.enableExtensionPack = true;
}
