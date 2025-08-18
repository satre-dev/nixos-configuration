# users/satre-home.nix - Home Manager configuration for user satre
{ config, pkgs, ... }:

{
  home.username = "satre";
  home.homeDirectory = "/home/satre";

  # User-specific packages
  home.packages = with pkgs; [
    # Development tools
    ripgrep         # For searching in Emacs and general use
    fd              # Fast file finder

    # Language servers for your languages
    gopls           # Go language server
    rust-analyzer   # Rust language server
    omnisharp-roslyn # C# language server

    # Additional development tools
    git
    fzf
  ];

  # Programs configuration
  programs = {
    # Enable Home Manager to manage itself
    home-manager.enable = true;

    # Emacs - just the package and basic setup
    emacs = {
      enable = true;
      package = pkgs.emacs30-gtk3;
      # Keep elisp config separate - no extraConfig here
    };

  };

  # Services
  services = {
    # Emacs daemon
    emacs = {
      enable = true;
      client.enable = true;
      defaultEditor = true;
      startWithUserSession = true;
    };
  };

  # XDG configuration
  xdg = {
    enable = true;

    # Set Emacs as default editor for text files
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = "emacsclient.desktop";
        "application/x-shellscript" = "emacsclient.desktop";
      };
    };
  };

  # Home Manager state version
  home.stateVersion = "24.05";
}
