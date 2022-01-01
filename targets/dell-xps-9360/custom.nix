{ config, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot = {
    cleanTmpDir = true;
    #tmpOnTmpfs = true;

    kernel.sysctl = {
      "vm.overcommit_memory" = 2;

      # TODO: Remove once kernel issue is resolved
      # https://askubuntu.com/questions/1185491/ubuntu-19-10-freezes-and-lags-reguarly
      "vm.swappiness" = 25;
    };

    kernelModules = [
      "af_packet"
      "v4l2loopback"
    ];
    extraModulePackages = [
      config.boot.kernelPackages.v4l2loopback
    ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 video_nr=10 card_label="v4l2-cam"
    '';
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub.device = "/dev/nvme0n1";
    };
    initrd.luks.devices = {
      "base.crypt.small" = {
        device = "/dev/nvme0n1p3"; # 100 GiB
        preLVM = true;
      };
      "store" = {
        device = "/dev/nvme0n1p5"; # 300 GiB
        preLVM = true;
      };
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = true;

    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
      ];
    };
  };

  fileSystems."/home" = {
    device = "/dev/mapper/store-store";
    fsType = "btrfs";
  };

  fileSystems."/nix" = {
    device = "/dev/nvme0n1p6";
    fsType = "btrfs";
    neededForBoot = true;
    options = [ "noatime" ];
  };

  #  fileSystems."/home" = {
  #    device = "/dev/disk/by-label/store";
  #    fsType = "btrfs";
  #  };
}
