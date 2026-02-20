{ }:

{
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
}
