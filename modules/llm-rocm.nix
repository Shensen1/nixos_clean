{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    
    ollama
    clblast
    #shell_gpt
    whisper
    libretranslate
  ];


  services.ollama.enable = true;
  services.ollama.acceleration = "rocm";
  services.ollama.host = "127.0.0.1";
  services.ollama.port = 11434;

  ###
}
