{ config, pkgs, lib, pkgs-stable, personalValues, ...}:
{

    environment.systemPackages = [
        pkgs.ollama
        pkgs.clblast
        #shell_gpt
        pkgs.whisper
        pkgs.libretranslate

    ];

    services.ollama.enable = true;
    services.ollama.acceleration = "rocm";
    services.ollama.host = "127.0.0.1";
    services.ollama.port = 11434;


###

}