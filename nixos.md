# NixOS installation steps

## Legacy Boot (skip)

```bash
parted /dev/vda -- mklabel msdos
parted /dev/vda -- mkpart primary 1MB 512MB
parted /dev/vda -- set 1 boot on
parted /dev/vda -- mkpart primary 512MB 100%
```

## EFI

create GPT partition table

```bash
parted /dev/sda -- mklabel gpt
```

root partition starting after the 512MB `boot` section

```bash
parted /dev/sda -- mkpart primary 512MB 100%
```

boot partition in the first 512MB
> the 2 in `set 2 esp on` should be the id/number of the boot partition

```bash
parted /dev/sda -- mkpart ESP fat32 1MB 512MB
parted /dev/sda -- set 2 esp on
```

LUKS encryption

```bash
cryptsetup luksFormat /dev/sda1
cryptsetup config /dev/sda1 --label cryptroot
cryptsetup luksOpen /dev/sda1 cryptroot
```

zero/format the encrypted partition to be extra paranoid

```bash
dd if=/dev/zero of=/dev/mapper/cryptroot status=progress
```

create a LVM pv

```bash
pvcreate /dev/mapper/cryptroot
```

create a LVM volume group

```bash
vgcreate vg /dev/mapper/cryptroot
```

create the swap volume

```bash
lvcreate -L 8G -n swap vg
```

create the root volume

```bash
lvcreate -l100%FREE -n root vg
```

mkswap for swap volume

```bash
mkswap -L swap /dev/vg/swap
```

mkfs ext4 for root volume

```bash
mkfs.ext4 -L nixos /dev/vg/root
```

mkfs the FAT boot volume

```bash
mkfs.fat -F 32 -n boot /dev/sda2
```

## Installing

mount root volume

```bash
mount /dev/disk/by-label/nixos /mnt
```

mount boot partition

```bash
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
```

OPTIONAL, when low RAM: activate swap during the installation

```bash
swapon /dev/vg/swap
```

generate initial nixos config:

```bash
nixos-generate-config --root /mnt
```

edit nix config

```bash
vim /mnt/etc/nixos/configuration.nix
```

install

```bash
nixos-install
```

## after installation

install home-manager

clone dotfiles

```bash
cd /home/markus/Documents
git clone git@github.com:Markus-Schwer/dotfiles.git
sudo chown -R markus:users /home/markus/Documents/dotfiles
```

