{ config, pkgs,  ... }:
{

#AMD CPU Config
  boot.kernelModules = [ "kvm-amd" ];
  powerManagement.cpuFreqGovernor = "performance";
  nixpkgs.hostPlatform = "x86_64-linux";
  #hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;



#AMD Grafikkarte

  hardware.opengl.driSupport = true;
  hardware.opengl.extraPackages = with pkgs; [
    rocmPackages.clr.icd
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

*/



  #---


  boot.initrd.availableKernelModules = [ "nvme" "ahci" "xhci_pci" "ehci_pci" "usbhid" "usb_storage" "uas" "sd_mod" "sr_mod" "amdgpu" ];
  boot.initrd.kernelModules = [ "dm-snapshot"   ];






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
