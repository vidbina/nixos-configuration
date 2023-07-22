{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libva-utils
    vdpauinfo
    vulkan-tools
    intel-gpu-tools
  ];

  nixpkgs.config.packageOverrides = pkgs: { };

  boot.loader.grub = {
    font = "${pkgs.dejavu_fonts}/share/fonts/truetype/DejaVuSansMono.ttf";
    fontSize = 36;

    # NOTE: From 2.06 to 2.12-rc1 missing shim symbol breaks the bootloader
    # see https://github.com/NixOS/nixpkgs/issues/243026

    # Workaround: Produce normal boot menu on a unaffected GRUB2 version

    # Note that we can workaround by:
    # - prepping a NixOS pendrive
    # - booting into GRUB2 from the pendrive (v2.06)
    # - Run: set prefix=(hd1,gpt2)/grub
    # - Run: set root=(hd1,gpt2)
    # - Run: insmod normal
    # - Run: normal
    extraGrubInstallArgs = [
      "--disable-shim-lock"
    ];
  };

  # https://wiki.archlinux.org/title/Hardware_video_acceleration#Verification
  hardware = {
    # https://nixos.wiki/wiki/OpenGL
    # https://nixos.wiki/wiki/Accelerated_Video_Playback
    opengl = {
      enable = true;

      driSupport = true;
      driSupport32Bit = true;

      extraPackages = with pkgs; [
        # Installing linux firmware as per
        # https://wiki.archlinux.org/title/Hardware_video_acceleration
        linux-firmware
        mesa.drivers
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
      ];

      extraPackages32 = with pkgs.pkgsi686Linux; [
        # Installing linux firmware as per
        # https://wiki.archlinux.org/title/Hardware_video_acceleration
        linux-firmware
        mesa.drivers
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
      ];
    };

    # https://nixos.wiki/wiki/Nvidia
    # our card is mux-less/non-MXM Optimus (shows up as 3D controller in lspci instead of VGA Controller)
    nvidia = {
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement.enable = true;
      prime = {
        #offload.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  # https://nixos.org/manual/nixos/stable/#sec-x11--graphics-cards-intel

  # Listing just the NVIDIA driver as per:
  # https://github.com/NixOS/nixpkgs/issues/108018
  services.xserver.videoDrivers = [ "nvidia" "intel" ];
}
