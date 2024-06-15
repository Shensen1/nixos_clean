{ config, pkgs, lib, modulesPath, ... }:
{
    imports = [
        ./hardware-configuration.nix
        ./networking.nix
        ./wgServer.nix
        ./nfs.nix
    ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "VPS1";
  networking.domain = "";
  users.users.root.openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHJAkeS/nrp7WrQ2HMrVkO0YxTi0uPPw8Mv1IyF5SJbW'' ];
  system.stateVersion = "23.11";
}