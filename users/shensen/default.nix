{softSecrets, ...}: {
  users.users = {
    shensen = {
      isNormalUser = true;
      home = "/home/shensen";
      hashedPassword = softSecrets.users.shensen.hashedPassword;
      extraGroups = [];
      group = "shensen";

      openssh.authorizedKeys.keys = [
        softSecrets.hosts.shensen-desktop.publicKey
        softSecrets.hosts.shensen-laptop.publicKey
        softSecrets.users.shensen.publicKey
      ];
    };
  };
  users.groups.shensen = {};
}
