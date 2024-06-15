{ config, pkgs, ... }:
{
  imports =
    [
      ./firewall.nix
      ./smb.nix
      ./networking.nix
      ./wgClient.nix
    ];

}
