{
  config = {
    age.secrets.sourcegraph = {
      file = ../secrets/sourcegraph.age;
      owner = "markus";
      group = "users";
    };

    age.secrets.nextcloud = {
      file = ../secrets/davfs2-secrets.age;
      owner = "root";
      group = "root";
      path = "/etc/davfs2/secrets";
      mode = "600";
    };
  };
}
