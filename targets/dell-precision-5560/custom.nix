{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libva-utils
    vdpauinfo
    vulkan-tools
    intel-gpu-tools
  ];

  nixpkgs.config.packageOverrides = pkgs: {
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
        vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
      ];

      extraPackages32 = with pkgs.pkgsi686Linux; [
        # Installing linux firmware as per
        # https://wiki.archlinux.org/title/Hardware_video_acceleration
        linux-firmware
        mesa.drivers
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
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
