{ config, pkgs, ... }:
{

  networking.hostName = "VPS1"; # Define your hostname.
  system.stateVersion = "23.11"; # Did you read the comment?

root@vps2249844:~# hostname
vps2249844.fastwebserver.de
root@vps2249844:~# ip --brief address
lo               UNKNOWN        127.0.0.1/8 ::1/128 
venet0           UNKNOWN        127.0.0.1/32 62.141.37.79/24 2001:4ba0:cafe:1290::1/128 




root@vps2249844:~# wg genkey
2EQaoFDaCxIG03vjnT/tkJ3Nue8VNwOEu+nrNH3zZl4=
root@vps2249844:~# wg genkey | sudo tee /etc/wireguard/private.key
6AfNndyl3l3ALKhUzqm0k0Y/ksGTaHvX+ZLinFeBV1A=
root@vps2249844:~# sudo chmod go= /etc/wireguard/private.key
root@vps2249844:~# sudo cat /etc/wireguard/private.key | wg pubkey | sudo tee /etc/wireguard/public.key
Pqut5yca1QQ6Qg182VmYUdf6/PsEEMKPOvPDY0Bfl0A=




#################


    environment.etc."nextcloud-admin-pass".text = "PWD";



    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud28;
      hostName = "cloud.localhost";
      configureRedis = true;
      https = true;
      config.adminpassFile = "/etc/nextcloud-admin-pass";



      extraOptions.enabledPreviewProviders = [
        "OC\\Preview\\BMP"
        "OC\\Preview\\GIF"
        "OC\\Preview\\JPEG"
        "OC\\Preview\\Krita"
        "OC\\Preview\\MarkDown"
        "OC\\Preview\\MP3"
        "OC\\Preview\\OpenDocument"
        "OC\\Preview\\PNG"
        "OC\\Preview\\TXT"
        "OC\\Preview\\XBitmap"
        "OC\\Preview\\HEIC"
      ];
    };



    services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
      forceSSL = true;
      enableACME = true;
    };



    security.acme = {
      acceptTerms = true;
      certs = {
        ${config.services.nextcloud.hostName}.email = "your-letsencrypt-email@example.com";
      };
    };




}
