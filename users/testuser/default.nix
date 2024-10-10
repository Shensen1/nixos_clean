{
  config,
  pkgs,
  softSecrets,
  ...
}: {
  users.users = {
    testuser4 = {
      isNormalUser = true;
      #home = "/home/testuser";

      #hashedPasswordFile

      hashedPassword = "$6$OmzkjPl./P0kPqkx$9SC35uHpr2pybKQ0.PqOfpi5UV0dQXK1eBnCqfgZ44piJLZYoW.XUTn2AD7mg4DuANjB0guItF626wfaXfAS9.";
      extraGroups = ["wheel"];
      group = "testuser";

      openssh.authorizedKeys.keys = [
        softSecrets.hosts.shensen-desktop.publicKey
        softSecrets.hosts.shensen-laptop.publicKey
        softSecrets.users.shensen.publicKey
      ];
    };
  };
  users.groups.testuser = {};
}
