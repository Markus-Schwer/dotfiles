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
      primary = true;
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
  };
}
