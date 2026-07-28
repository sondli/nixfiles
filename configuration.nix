{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./system/gaming.nix
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      configurationLimit = 3;
    };
  };

  programs.thunar.enable = true;

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than +5";
  };

  networking.hostName = "desktop";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Bucharest";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us,no,ro";
    variant = "";
  };

  users.users.sondli = {
    isNormalUser = true;
    description = "sondli";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "plugdev"
      "docker"
    ];
  };

  # services.udev.extraRules = builtins.readFile ./rules/50-zsa.rules;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    pavucontrol
    google-chrome
    imagemagick
    neovim
    radeontop
    dbeaver-bin
    jetbrains.rider
		azure-cli
		insomnia
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

	boot.loader.grub.useOSProber = true;
	time.hardwareClockInLocalTime = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # To solve sass needing linked libs
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    glibc
    libcxx
  ];

  programs.ssh = {
    startAgent = true;
  };

  virtualisation = {
    docker.enable = true;
  };

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  system.stateVersion = "25.11";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

}
