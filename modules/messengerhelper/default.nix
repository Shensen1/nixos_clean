{pkgs, config, ...}:{



  environment.systemPackages = (with pkgs; [
    #asyncio
    python3
    openai-whisper
    signal-cli
    signal-export

    telegram-bot-api

    # ComfyUI
    python312Packages.torch
    python312Packages.torchvision
    

    # rocm
    rocmPackages.rpp


  ]);

}