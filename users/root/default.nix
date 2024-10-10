{softSecrets, ...}: {
  users.mutableUsers = false;
  users.users = {
    root = {
      #group = "root";
      hashedPassword = softSecrets.users.root.hashedPassword;

      openssh.authorizedKeys.keys = [
        softSecrets.hosts.shensen-desktop.publicKey
        softSecrets.hosts.shensen-laptop.publicKey
        softSecrets.users.shensen.publicKey
      ];
    };
  };
}
