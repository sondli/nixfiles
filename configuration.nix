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

  services.udev.extraRules = builtins.readFile ./rules/50-zsa.rules;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    git
    vesktop
    fastfetch
    btop
    pavucontrol
    fzf
    ripgrep
    unzip
    google-chrome
    imagemagick
    radeontop
    dbeaver-bin
    inotify-tools
    flyctl
    jetbrains.rider
    netcoredbg
    jq
  ];

  services.xserver = {
    enable = true;
    displayManager = {
      gdm.enable = true;
    };
  };

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.ssh = {
    startAgent = true;
  };

  virtualisation = {
    docker.enable = true;
    virtualbox = {
      host.enable = true;
      host.enableExtensionPack = true;
			host.enableKvm = true;
			host.addNetworkInterface = false;
      guest.enable = true;
      guest.dragAndDrop = true;
    };
  };
  users.extraGroups.vboxusers.members = [ "sondli" ];

  security.rtkit.enable = true;
  security.pki.certificates = [
    ''
      -----BEGIN CERTIFICATE-----
      MIIDDTCCAfWgAwIBAgIJAIK9SIGboH/VMA0GCSqGSIb3DQEBCwUAMBQxEjAQBgNV
      BAMTCWxvY2FsaG9zdDAeFw0yNDA1MTgxMzU0MDNaFw0yNTA1MTgxMzU0MDNaMBQx
      EjAQBgNVBAMTCWxvY2FsaG9zdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
      ggEBAMnMuV/2VopQRgABBPS3biRtXdGIR27b0AB+nuV7QHkU9N880ouJRe2DbN3Z
      5oYGMJsIPSQUXUPqvcMQgJsdSkNyGcNQAZVEHAg+oHsD04KctLoT+PDLZxydYl11
      mBDaRhfEfpl5Pf6xr3Rk7IXNcDzb5ku2DeOu3LBLLZify9yIsL2FzdcC4Nj+ZhgG
      Dhgwjw541wTmK2Atuu2J4Nuk5j/Y2pRP22BcNHbiPmxrKxI479p8s3pFlDm7EfKN
      9GaVbM2W97zxX4zvOpn2TRuQN4lY37pz8mx1KFlI0bq3tXOluGiQHdlN0VG+/JSb
      UxDIcF6hgbD4AneyCpW767xzs0sCAwEAAaNiMGAwDAYDVR0TAQH/BAIwADAOBgNV
      HQ8BAf8EBAMCBaAwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwEwFwYDVR0RAQH/BA0w
      C4IJbG9jYWxob3N0MA8GCisGAQQBgjdUAQEEAQIwDQYJKoZIhvcNAQELBQADggEB
      ADhf6wYyl5SOALh7CymJRDb//0O88fNu8ZaO765aLepIFgRAJNAADjmpCivqjXRJ
      L3TwAcCA+axtdlg34cd3lrgKZ0xJ1jcmR3k1kHQk9y3wyW27CHzz/0fVcbcCekj1
      BLeL00TQ6WO2zW9pZ6XMsqLojtWPBliwK4McBpzUPg+17AQBwtXjODCuKRi2WuFk
      2AgnhBDdR020E94xR/O58mnXEkmkHVZXzBmJhcAfdO4PCWa+nAQAeOd1hZbZZ2Hn
      5eIUeiUGXRNv2h/ZAdZ6t2p590UgubLIrPUJgD8wzGCAAYS6rmFmxSOIyEAfH9d6
      onik1T5+aMTX5J5mOSiWRv8=
      -----END CERTIFICATE-----
    ''
  ];

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  system.stateVersion = "23.11";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

}
