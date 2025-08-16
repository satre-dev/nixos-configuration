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
    
    # Editors
    vim
    neovim
    emacs
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
        commit.gpgsign = true;  # Fixed typo
        gpg.program = "${pkgs.gnupg}/bin/gpg";
      };
    };
  };
}
