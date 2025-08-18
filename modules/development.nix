{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Development tools
    go
    rustc
    gcc15
    cargo
    dotnet-sdk
    github-cli
    fastfetch # absolutely necessary
    nodejs
    zsh

    # Editors
    vim

    # Utils
    unzip
  ];

  programs = {
    bash.completion.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

  };
}
