{ osConfig, ... }:
{
  programs.bash = {
    bashrcExtra = ''
      export SRC_ENDPOINT="https://sourcegraph.com"
      export SRC_ACCESS_TOKEN=$(cat ${osConfig.age.secrets.sourcegraph.path})
    '';
  };
}
