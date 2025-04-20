{ pkgs, config, ... }:
let
  resticRepository = "s3:https://s3.us-east-005.backblazeb2.com/restic-ubuhww9olkdxb4";
  excludeFile = pkgs.writeText "restic-excludes.txt"
    ''
      /home/markus/.bash_history
      /home/markus/.bash_profile
      /home/markus/.bashrc
      /home/markus/.cache
      /home/markus/.config
      /home/markus/.local
      /home/markus/.vscode
      /home/markus/go
      node_modules
      __pycache__
    '';
in
{
  services.restic.backups.b2 = {
    user = "markus";
    initialize = true;
    passwordFile = config.age.secrets.resticPassword.path;
    repository = resticRepository;
    environmentFile = config.age.secrets.resticEnvironmentSecrets.path;
    paths = [ "/home/markus" ];
    pruneOpts = [
      "--keep-hourly 48"
      "--keep-daily 7"
      "--keep-weekly 4"
      "--keep-monthly 12"
      "--keep-yearly 5"
    ];
    extraOptions = [ "s3.region=us-east-005" ];
    extraBackupArgs = [ "--exclude-caches" "--exclude-file=${excludeFile}" ];
    timerConfig = {
      OnCalendar = "hourly";
      Persistent = true;
    };
  };

  systemd.services."restic-backups-b2" = {
    onFailure = [ "restic-unlock.service" ];
  };

  systemd.services."restic-unlock" = {
    serviceConfig = {
      Type = "oneshot";
      User = "markus";
      EnvironmentFile = config.age.secrets.resticEnvironmentSecrets.path;
      ExecStart = "${pkgs.restic}/bin/restic -o s3.region=us-east-005 --repository ${resticRepository} --password-file ${config.age.secrets.resticPassword.path} unlock";
    };
    onSuccess = [ "restic-backups-b2.service" ];
  };
}
