{
  programs.thunderbird = {
    enable = true;
    profiles.default.isDefault = true;
  };

  accounts.email.accounts = {
    hackwerk = {
      realName = "Markus Schwer";
      address = "markus.schwer@aalen.space";
      userName = "markus.schwer@aalen.space";
      primary = false;
      thunderbird = {
        enable = true;
      };

      imap = {
        host = "mail.aalen.space";
        port = 993;
        tls.enable = true;
      };
      smtp = {
        host = "mail.aalen.space";
        port = 465;
        tls.enable = true;
      };
    };
    protonmail = {
      realName = "Markus Schwer";
      address = "markus.schwer@protonmail.com";
      userName = "markus.schwer@protonmail.com";
      primary = true;
      thunderbird = {
        enable = true;
      };

      imap = {
        host = "127.0.0.1";
        port = 1143;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };
      smtp = {
        host = "127.0.0.1";
        port = 1025;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };
    };
  };
}
