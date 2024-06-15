{
  
  
  fileSystems."/export/home" = {
    device = "/home";
    options = [ "bind" ];
  };



  services.nfs.server = {
    enable = true;
  # fixed rpc.statd port; for firewall
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000;
    extraNfsdConfig = '''';
  
    exports = ''
    /export  10.0.0.3(rw,nohide,insecure,no_subtree_check) 10.0.0.4(rw,nohide,insecure,no_subtree_check)
      '';
  };

  
  networking.firewall = {
    #enable = true;
      # for NFSv3; view with `rpcinfo -p`
    allowedTCPPorts = [ 111  2049 4000 4001 4002 20048 ];
    allowedUDPPorts = [ 111 2049 4000 4001  4002 20048 ];
  };


}