{
  softSecrets,
  config,
  pkgs,
  pkgs-stable,
  ...
}: {
  sops = {
    #defaultSopsFile = ./personal.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    #age.keyFile = "/persist/sops.txt";

    secrets = {
      "gh_deploykey" = {
        sopsFile = ./../../allHosts.yaml;
        path = "/var/secrets/gh_deploykey";
        mode = "0600";
        owner = config.users.users.minion.name;
        group = config.users.users.minion.group;
      };
    };
  };

  users.users = {
    minion = {
      hashedPassword = softSecrets.users.minion.hashedPassword;
      isNormalUser = true;
      home = "/home/minion";
      extraGroups = ["wheel"];
      group = "minion";

      openssh.authorizedKeys.keys = [
        softSecrets.hosts.shensen-desktop.publicKey
        softSecrets.hosts.shensen-laptop.publicKey
        softSecrets.users.shensen.publicKey
      ];
    };
  };
  users.groups.minion = {};

  programs.ssh.extraConfig = "
  Host github-nixos
    HostName github.com
    AddKeysToAgent yes
    PreferredAuthentications publicKey
    IdentityFile ${config.sops.secrets.gh_deploykey.path}
";

  services.self-deploy.sshKeyFile = "/home/minion/.ssh/deploykey";
}
