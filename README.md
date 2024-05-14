# Yuki - NixOS dotfiles

## Running system
### Prerequisite
- Make sure you've enabled nix flakes.

### Steps
1. Clone this repo (I'm using `testing` branch) (you can use ssh link)
```bash
git clone -b testing https://github.com/aqu4holic/yuki.git
# git clone git@github.com:Aqu4holic/yuki.git
```

2. Create a symlink from the downloaded folder to `/etc/nixos`
```bash
# use absolute path
sudo ln -s path/to/yuki/flake.nix /etc/nixos/
```

3. Copy the `hardware-configration.nix` file
```bash
cp --no-preserve=ownership /etc/nixos/hardware-configuration.nix yuki/hosts/blackwhite/hardware-configuration.nix
```

4. Rebuild the system
```bash
# this will also rename your hostname, so next time you can just nixos-rebuild switch
cd yuki
sudo nixos-rebuild switch --flake .#yuki
```

## Dual booting and install from miminal iso

### 1. Partitioning

```bash
sudo su
```

These are **CASE SENSITIVE!!!**
**1Mib != 1MiB**
**CHANGE DRIVE NAME, sdaX -> nvme0X or something!!!!**

```bash
# begin
parted /dev/sda -- mklabel gpt (for uefi)
parted /dev/sda -- mkpart primary XGiB -8GiB (first one for boot, X = 1 on VM, 8 on main)
parted /dev/sda -- mkpart primary linux-swap -8GiB 100%

# for uefi
parted /dev/sda -- mkpart ESP fat32 1Mib XGiB
parted /dev/sda -- set 3 esp on

mkfs.ext4 -L yuki /dev/sda1
mkswap -L swap /dev/sda2

# for uefi
mkfs.fat -F 32 -n boot /dev/sda3
```

### 2. Mounting

```bash
mount /dev/disk/by-label/yuki /mnt

# for uefi
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot

swapon /dev/sda2
```

### 3. Pre-install config

#### 3.1 Generate

```bash
nixos-generate-config --root /mnt

cd /mnt/etc/nixos

l
```

#### 3.2 Config

##### 3.2.1 `configuration.nix`
```nix
boot.loader = {
    efi = {
        canTouchEfiVariables = true;
        # efiSysMountPoint = "/boot/efi"; (gotta test this)
    };

    grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
    };
};

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// IMPORTANT TO IMPORT CONFIGS
nixpkgs.config.allowUnfree = true;

nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
};
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

networking.hostName = "yuki";
networking.networkmanager.enable = true;

time.timeZone = "Asia/Ho_Chi_Minh";

i18n all, add lib.mkForce to "us";

services.xserver.enable = true;

services.xserver.xkb.layout = "us";

users.users.blackwhite = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
};

environment.systemPackages = with pkgs; [
    vim
    wget
    git
];
```

##### 3.2.2 `hardware-configuration.nix`

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
update settings according to your graphics device
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

```nix
file.sysTems = {
    "/" = {
        device = "/dev/disk/by-label/yuki";
        fsType = "ext4";
    };

    "/boot" = {
        device = "/dev/disk/by-label/boot";
        fsType = "vfat";
        options = [
            "fmask=0022";
            "dmask=0022";
        ];
    };
};

swapDevices = [
    {
        device = "/dev/disk/by-label/swap";
    };
];
```

### 4. Installation

```bash
nixos-install

# after that, remove the boot usb
reboot

# ctrl + alt + f1: tty
# login as root, set password for user
sudo passwd blackwhite

# remember to exit sudo
exit
```

### 5. Post-install config

1. CLone this repo (I'm using `testing` branch) (you can use ssh link)
```bash
git clone -b testing https://github.com/aqu4holic/yuki.git
```

2. Copy the `hardware-configration.nix` file
```bash
cp --no-preserve=ownership /etc/nixos/hardware-configuration.nix yuki/hosts/blackwhite/hardware-configuration.nix
```

3. Uncomment `efiSupport = true;` in `hosts/blackwhite/default.nix`

4. Create a symlink from the downloaded folder to `/etc/nixos`
```bash
# use absolute path, for my case its the below
sudo ln -s home/blackwhite/download/github/yuki/flake.nix /etc/nixos/
```

5. Rebuild the system
```
# this will also rename your hostname, so next time you can just nixos-rebuild switch
cd yuki
sudo nixos-rebuild switch --flake .#yuki
```

## Things to do
- update more configs

- update hardware settings to nvidia ([wiki](https://nixos.wiki/wiki/Nvidia))

- update bspwmrc to the current monitor, rn using -d, not good enough

- rememeber to change picom render engine

- add `efiSupport = true;` to the main config

thx for ur reading :)