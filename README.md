# NixOS configuration

## NixOS installation steps

1. Boot into a nix 23.05 (or newer) minimal ISO
> if you want to use WIFI in the minimal ISO
> create config: `wpa_passphrase <SSID> <PW> | sudo tee /etc/wpa_supplicant.conf`
> activate it: `sudo wpa_supplicant -B -c /etc/wpa_supplicant.conf -i wlp3s0`
2. clone the repository `git clone https://github.com/Markus-Schwer/dotfiles`
3. write the full-disk-encryption password into a file `read -s password | echo -n $password > /tmp/secret.key`
4. Run `sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko dotfiles/disk-config.nix --arg disk '"/dev/nvme0n1"'`
5. Run `nixos-install --flake "github:Markus-Schwer/dotfiles#<hostname>"`
> May require to use `--experimental-features "nix-command flakes"`
5. Reboot

## After installation

clone dotfiles nix flake

```bash
mkdir /home/markus/Documents
cd /home/markus/Documents
git clone git@github.com:Markus-Schwer/dotfiles.git
sudo chown -R markus:users /home/markus/Documents/dotfiles
```


