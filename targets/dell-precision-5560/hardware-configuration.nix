# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    enableCryptodisk = true;
  };

  boot.initrd.luks.devices = {
    work = {
      device = "/dev/disk/by-uuid/aec42bca-13b6-48af-b41a-c7b0f5573a84";
      preLVM = true;
    };
  };

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/28ee814d-75d1-4673-87b3-2f1a66c1bce5";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/62CA-86FD";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/d43e9ac4-b767-4da0-9e64-c33f51991fb8"; }];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
