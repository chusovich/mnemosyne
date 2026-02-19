# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix # Include the results of the hardware scan.
    ];

  # ZFS
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.extraPools = [ "media-pool" ];
  services.zfs.autoScrub.enable = true;
  networking.hostId = "4e24220d"; # so ZFS can identify the server

  # Restic Backups
  services.restic.backups = {
    immich = {
      user = "mnemosyne";
      repository = "sftp:backup@192.168.1.100:/backups/‹name›";
      initialize = true; # initializes the repo, don't set if you want manual control
      passwordFile = "<path>";
      paths = [ "/mnt/immich" ];
      timerConfig = {
        onCalendar = "saturday 03:00";
      };
      pruneOpts = [
        "--keep-weekly 5"
        "--keep-monthly 24"
        "--keep-yearly 75"
      ]
    };
    paperless = {
      user = "mnemosyne";
      repository = "sftp:backup@192.168.1.100:/backups/‹name›";
      initialize = true; # initializes the repo, don't set if you want manual control
      passwordFile = "<path>";
      paths = [ "/mnt/paperless" ];
      timerConfig = {
        onCalendar = "saturday 03:15";
      };
      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
        "--keep-yearly 75"
      ]
    };
  };

  # Network Configuration
  networking = {
    hostName = "mnemosyne";
    interfaces = {
      enp1s0 = {
        useDHCP = false;
        ipv4.addresses = [ {
          address = "192.168.10.20";
          prefixLength = 24;
        } ];
      };
    };
    defaultGateway = "192.168.10.1";
    nameservers = [ "192.168.10.1" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
