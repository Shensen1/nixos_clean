{ config, pkgs,  ... }:
{

#AMD CPU Config
  boot.kernelModules = [ "kvm-amd" ];
  powerManagement.cpuFreqGovernor = "performance";
  nixpkgs.hostPlatform = "x86_64-linux";
  #hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;



#AMD Grafikkarte
#  RX6600XT (gfx1032,navi23)
  hardware.opengl.driSupport = true;
# hardware.opengl.package = pkgs.linuxKernel.packages.linux_6_6.amdgpu-pro;
  hardware.opengl.extraPackages = with pkgs; [
    rocmPackages_5.rpp-cpu
    rocmPackages.rocm-smi
    linuxKernel.packages.linux_6_6.amdgpu-pro
    amdvlk
  ];
  # 32-bit graphics libraries
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  #Most software has the HIP libraries hard-coded. You can work around it on NixOS by using:
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];




/*
  environment.sessionVariables = {
    # I don't know why VA-API can't find the driver without this...
    LIBVA_DRIVER_NAME = "amdgpu";

    # Seems to be necessary for the vaapi implementation to function due to an nvidia bug
    #NVD_BACKEND = "direct";
  };

  boot.kernelParams = [
    "video=DP-10:1920x1080@60"
    "video=DP-9:1920x1080@60"
  ];
*/
  #---


  boot.initrd.availableKernelModules = [ "nvme" "ahci" "xhci_pci" "ehci_pci" "usbhid" "usb_storage" "uas" "sd_mod" "sr_mod" "amdgpu" ];
  #boot.initrd.kernelModules = [ "amdgpu" ];






 # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;




  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };



  hardware.bluetooth.enable = true;



  zramSwap.enable = true;
  zramSwap.memoryPercent = 150;


}
