{personalValues, ...}:{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = false;

programs.ssh.extraConfig = ''
  ServerAliveInterval 60
  ServerAliveCountMax 120
'';


  services.openssh.hostKeys = [
    { type = "rsa"; bits = 4096; path = "/etc/ssh/ssh_host_rsa_key"; }
    { type = "ed25519";          path = "/etc/ssh/ssh_host_ed25519_key"; }
  ];


/*
environment.interactiveShellInit = ''
  alias ssh-desktop='ssh -i ~/.ssh/ssh_shensen-laptop_ed25519_key shensen@192.168.0.102'
  alias ssh-laptop='ssh -i ~/.ssh/ssh_shensen-desktop_ed25519_key shensen@192.168.0.103'
  alias ssh-local='ssh -i ~/.ssh/ssh_shensen-laptop_ed25519_key shensen@localhost'
  alias ssh-vps1='ssh -i ~/.ssh/ssh_shensen-laptop_ed25519_key shensen@192.168.0.102'

'';
*/


}
