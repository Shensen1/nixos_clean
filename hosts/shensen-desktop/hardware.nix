{pkgs, ...}: {
  #AMD CPU Config
  boot.kernelModules = ["pstore" "kvm-amd"];
  boot.kernelParams = [
    "nohibernate"
  ];

  powerManagement.cpuFreqGovernor = "performance";
  nixpkgs.hostPlatform = "x86_64-linux";
  #hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  #AMD Grafikkarte
  #  RX6600XT (gfx1032,navi23)
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = 
    (with pkgs; [
      #ocl-icd
      #opencl-clhpp
      amdvlk
    ]) 

    ++ (with pkgs.rocmPackages_5; [

      clr.icd
      clr
      rocminfo
      rocm-runtime
      rpp
      #rpp-cpu
      #rpp-opencl
      rpp-hip
    ])

    ;

  #FIXME Mandelbulber blibla overraid
#(pkgs.mandelbulber.override {opencl-clhpp = pkgs.rocmPackages.rpp-hip;})
  
  
  # 32-bit graphics libraries
  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  #Most software has the HIP libraries hard-coded. You can work around it on NixOS by using:
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  /*
  environment.sessionVariables = {
    # As of ROCm 4.5, AMD has disabled OpenCL on Polaris based cards. So this is needed if you have a 500 series card.
    ROC_ENABLE_PRE_VEGA = "1";

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

  boot.initrd.availableKernelModules = ["nvme" "ahci" "xhci_pci" "ehci_pci" "usbhid" "usb_storage" "uas" "sd_mod" "sr_mod" "amdgpu"];
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


