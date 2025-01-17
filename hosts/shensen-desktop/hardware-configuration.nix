# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/e4cd880a-e0fe-4e00-9247-59b51ac55ddf";
    fsType = "btrfs";
    options = ["subvol=@"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/1FDB-B7BC";
    fsType = "vfat";
  };

  fileSystems."/mnt/SSD" = {
    device = "/dev/disk/by-uuid/35205437-f61a-4af0-84af-0974f03561c7";
    fsType = "btrfs";
  };

  fileSystems."/mnt/HDD" = {
    device = "/dev/disk/by-uuid/3f887a73-8e12-4bbd-96cc-55d2d45e2787";
    fsType = "btrfs";
  };

  #  fileSystems."/root/.cache/doc" =
  #    { device = "portal";
  #      fsType = "fuse.portal";
  #    };

  fileSystems."/home/shensen/Steamlibs/SSD_Steamlib" = {
    device = "/dev/disk/by-uuid/35205437-f61a-4af0-84af-0974f03561c7";
    fsType = "btrfs";
    options = ["subvol=SSD_Steamlib"];
  };

  fileSystems."/home/shensen/Steamlibs/HDD_Steamlib" = {
    device = "/dev/disk/by-uuid/3f887a73-8e12-4bbd-96cc-55d2d45e2787";
    fsType = "btrfs";
    options = ["subvol=HDD_Steamlib"];
  };

  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp14s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.vboxnet0.useDHCP = lib.mkDefault true;

  #nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
