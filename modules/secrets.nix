{
  config.age.secrets = {
    sourcegraph = {
      file = ../secrets/sourcegraph.age;
      owner = "markus";
      group = "users";
    };

    nextcloud = {
      file = ../secrets/davfs2-secrets.age;
      owner = "root";
      group = "root";
      path = "/etc/davfs2/secrets";
      mode = "600";
    };

    resticPassword = {
      file = ../secrets/restic-password.age;
      owner = "markus";
      group = "users";
      mode = "600";
    };

    resticEnvironmentSecrets = {
      file = ../secrets/backblaze-b2-restic-s3-secrets.age;
      owner = "markus";
      group = "users";
      mode = "600";
    };
  };
}
