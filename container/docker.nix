{
  pkgs,
  config,
  username,
  ...
}: {
  ##inherit username;

  environment.systemPackages = with pkgs; [
    arion # https://docs.hercules-ci.com/arion/

    # Do install the docker CLI to talk to podman.
    # Not needed when virtualisation.docker.enable = true;
    docker
    docker-client
  ];

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  users.users.${username}.extraGroups = ["docker"];

  #If you prefer, you could achieve the same with this:
  #users.extraGroups.docker.members = [ "username-with-access-to-socket" ];
}
