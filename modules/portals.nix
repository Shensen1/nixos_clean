{ config, pkgs, ... }:
{
  #xdg.portal.enable = true;
  #xdg.portal.xdgOpenUsePortal = true;
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-kde ];
  #xdg.portal.config.common.default = "*";


}
