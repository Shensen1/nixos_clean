{ config, pkgs, lib, my, username, ... }:
{

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      canon-cups-ufr2
      sane-backends
      gscan2pdf
    ;
  };

  hardware.sane.enable = true; # enables support for SANE scanners
  services.printing.enable = true;
  users.users.shensen.extraGroups = [ "scanner" "lp" ];

}
