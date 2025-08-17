{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Development tools
    go
    rustc
    gcc15
    cargo
    dotnet-sdk
    git
    github-cli
    fastfetch # absolutely necessary
    nodejs
    zsh

    # Editors
    vim
    emacs

    # Utils
    unzip
  ];

  programs = {
    bash.completion.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    git = {
      enable = true;
      config = {
        init.defaultBranch = "main";
        pull.rebase = true;
        commit.gpgsign = true;
        gpg.program = "${pkgs.gnupg}/bin/gpg";
      };
    };
  };
}
