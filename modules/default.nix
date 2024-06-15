{ config, pkgs, ... }:
{

  imports = [
    ./display.nix
    ./portals.nix
    ./printermx435.nix

    ./wgSurfshark.nix


    ./vscode.nix
    
    ./ssh.nix
  ];




}
