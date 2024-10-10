{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.ollama
  ];

  services.ollama.enable = true;
  #services.ollama.acceleration = "cuda";
  services.ollama.host = "127.0.0.1";
  services.ollama.port = 11434;
}
