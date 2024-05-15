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
sudo ln -s /path/to/yuki/flake.nix /etc/nixos/
```

3. Copy the `hardware-configration.nix` file
```bash
cp --no-preserve=ownership /etc/nixos/hardware-configuration.nix yuki/hosts/blackwhite/hardware-configuration.nix
```

4. Change the username in `flake.nix` and `modules/system.nix` to your username

`flake.nix`
```nix
home-manager.nixosModules.home-manager {
    ...
    home-manager.users.<your_username_here> = import ./home;

    ...
}
```

`system.nix`
```nix
# at the beginning of the file
let username = "your_username_here";
```

5. Make bin/ folder executable
```bash
chmod +x yuki/bin/*
```

6. Rebuild the system
```bash
# this will also rename your hostname, so next time you can just nixos-rebuild switch
cd yuki
sudo nixos-rebuild switch --flake .#yuki
```

## Dual booting and install from miminal iso

### 0. Networking

#### Pre-install

If you're using wifi, first check the wifi interface name using this
```bash
ifconfig -a
```
After that, use `wpa_passphrase` to create a wifi config
```bash
# enter password after this
wpa_passphrase "SSID" > wifi.conf

wpa_supplicant -i wifi_interface -c wifi.conf -B

dhcpcd
```
#### Post-install

We can use nmcli now
```bash
nmcli dev wifi connect <SSID> password <password>
```
You can use any other ways that suits, the one I listed above works in my case

### 1. Partitioning

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
I SUGGESTED YOU TO USE A GRAPHICAL INSTALLATION AND USE GPARTED BECAUSE THIS IS ERROR-PRONE!!!!
IF YOU WANT TO DO IT MANUALLY, PROCEED
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

```bash
sudo su
```

These are **CASE SENSITIVE!!!**
**1Mib != 1MiB**
**CHANGE DRIVE NAME, sdaX -> nvme0X or something!!!!**

```bash
# begin
parted /dev/<your_device><your_number> -- mklabel gpt (for uefi)
parted /dev/<your_device><your_number> -- mkpart primary XGiB -8GiB (first one for boot, X = 1 on VM, 8 on main)
parted /dev/<your_device> -- mkpart primary linux-swap -8GiB 100%

# i found out the above wont work, you have to use cfdisk to manually split them into 3 parts and then

# for uefi
parted /dev/<your_device> -- mkpart ESP fat32 1Mib XGiB
parted /dev/<your_device> -- set <your number> esp on

mkfs.ext4 -L yuki /dev/<your_device><your_home_number>
mkswap -L swap /dev/<your_device><your_boot_number>

# for uefi
mkfs.fat -F 32 -n boot /dev/<your_device><your_number>
```

### 2. Mounting

```bash
mount /dev/disk/by-label/yuki /mnt

# for uefi
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot

swapon /dev/<your_device><your_number>
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

users.users.<your_username> = {
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
sudo passwd <your_username>

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

4. Change the username in `flake.nix` and `modules/system.nix` to your username

`flake.nix`
```nix
home-manager.nixosModules.home-manager {
    ...
    home-manager.users.<your_username_here> = import ./home;

    ...
}
```

`system.nix`
```nix
# at the beginning of the file
let username = "your_username_here";
```

5. Make bin/ folder executable
```bash
chmod +x yuki/bin/*
```

6. Create a symlink from the downloaded folder to `/etc/nixos`
```bash
# use absolute path, for my case its the below
sudo ln -s /home/blackwhite/download/github/yuki/flake.nix /etc/nixos/
```

7. Rebuild the system
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