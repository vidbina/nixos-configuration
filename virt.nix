{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    packer
    (vagrant.overrideDerivation(old: {
      preFixup = ''
        chmod -x $out/lib/ruby/gems/2.4.0/gems/vagrant-2.0.2/plugins/provisioners/salt/bootstrap-salt.sh
      '';
      postFixup = ''
        chmod +x $out/lib/ruby/gems/2.4.0/gems/vagrant-2.0.2/plugins/provisioners/salt/bootstrap-salt.sh
      '';
    }))
    qemu
  ];

  virtualisation.virtualbox.host.enable = true;

  nixpkgs.config.virtualbox.enableExtensionPack = true;
}
