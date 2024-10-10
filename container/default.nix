{config, pkgs, ... }: 
{



    sops = {
      defaultSopsFile = ./../personal.yaml;
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      #age.keyFile = "/persist/sops.txt";

  environment.systemPackages = (with pkgs; [
    arion # https://docs.hercules-ci.com/arion/

  ]);

programs.ssh.forwardX11 = true;

    networking.nat = {
    enable = true;
    internalInterfaces = ["ve-+"];
    externalInterface = "ens3";
    # Lazy IPv6 connectivity for the container
    enableIPv6 = true;
    };

}