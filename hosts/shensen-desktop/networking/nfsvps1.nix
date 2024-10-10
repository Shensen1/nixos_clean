{
  fileSystems."/mnt/vps1" = {
    device = "10.0.0.2:/export";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
      "nofail"
      "_netdev"

      #"rsize=8096"
      #"wsize=8096"
      "nfsvers=4.2"
      "soft"
    ];
  };
}
