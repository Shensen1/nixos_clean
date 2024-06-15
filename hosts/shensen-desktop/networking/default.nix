{ config, pkgs, ... }:
{
  imports =
    [
      ./firewall.nix
      ./smb.nix
      ./wgClient.nix
      ./nfsvps1.nix
    ];

}
