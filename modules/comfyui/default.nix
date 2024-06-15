{ config, pkgs, ... }:
{

  imports = [
    #./shell.nix
  ];

  environment.systemPackages = (with pkgs; [
    
    # ComfyUI
    python3
    python312Packages.torch
    python312Packages.torchvision
    
    # rocm6 
    rocmPackages.rpp


  ]);


}
