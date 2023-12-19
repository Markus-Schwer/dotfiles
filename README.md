# NixOS configuration

## NixOS installation steps

1. Boot into a nix 23.11 minimal ISO
> if you want to use WIFI in the minimal ISO
> create config: `wpa_passphrase <SSID> <PW> | sudo tee /etc/wpa_supplicant.conf`
> activate it: `sudo wpa_supplicant -B -c /etc/wpa_supplicant.conf -i wlp5s0`
2. Run `sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko github:Markus-Schwer/dotfiles#disko-config --arg disk '"/dev/nvme0n1"'`
3. Run `sudo nixos-install --flake github:Markus-Schwer/dotfiles#<hostname>`
4. Reboot

## After installation

clone dotfiles nix flake

```bash
mkdir /home/markus/Documents
cd /home/markus/Documents
git clone git@github.com:Markus-Schwer/dotfiles.git
sudo chown -R markus:users /home/markus/Documents/dotfiles
```


