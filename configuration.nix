{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/hyprland.nix
    ./modules/networking.nix
    ./modules/fonts.nix
    ./modules/development.nix
    ./modules/audio.nix
    ./users/satre.nix
  ];

  # Bootloader
  boot.loader.grub = {
    enable = true;
    device = "/dev/nvme0n1";
    useOSProber = true;
  };

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Locale and timezone
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Keyboard layout
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  security.rtkit.enable = true;

  # Ensure D-Bus is properly configured
  services.dbus.enable = true;

  # Add GNOME keyring (often needed for GTK portal)
  services.gnome.gnome-keyring.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Core system packages
  environment.systemPackages = with pkgs; [
    kitty
    librewolf
    htop
    wget
    curl
    tree
    gnupg
  ];

  system.stateVersion = "25.05";
}
