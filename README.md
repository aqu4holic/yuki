# NixOS configs

## Running system
### Prerequisite
- Make sure you've enabled nix flakes.

### Steps
1. Clone this repo (I'm using `testing` branch) (you can use ssh link)
```bash
git clone -b testing https://github.com/aqu4holic/nixos_rice.git
# git clone git@github.com:Aqu4holic/nixos_rice.git
```

2. Create a symlink from the downloaded folder to `/etc/nixos`
```bash
sudo ln -s nixos_rice/* /etc/nixos/
```

3. Copy the `hardware-configration.nix` file
```bash
cp --no-preserve=ownership /etc/nixos/hardware-configuration.nix nixos_rice/hosts/blackwhite/hardware-configuration.nix
```

4. Rebuild the system
```bash
cd nixos_rice
sudo nixos-rebuild switch --flake .#nix
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

mkfs.ext4 -L nixos /dev/sda1
mkswap -L swap /dev/sda2

# for uefi
mkfs.fat -F 32 -n boot /dev/sda3
```

### 2. Mounting

```bash
mount /dev/disk/by-label/nixos /mnt

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

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
**DONT FORGET NIX experimental-features**
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

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

networking.hostName = "nix";
networking.networkmanager.enable = true;

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
```nix
file.sysTems = {
	"/" = {
		device = "/dev/disk/by-label/nixos";
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
sudo su
passwd blackwhite

# should exit sudo su after this
exit

# login back
```

### 5. Post-install config

1. Make download directory
```bash
mkdir download
cd download
```

2. CLone this repo (I'm using `testing` branch) (you can use ssh link)
```bash
git clone -b testing https://github.com/aqu4holic/nixos_rice.git
```

3. Copy the `hardware-configration.nix` file and remove old config
```bash
# copy hardware-configuration.nix
cp --no-preserve=ownership /etc/nixos/hardware-configuration.nix nixos_rice/hosts/blackwhite/hardware-configuration.nix

# remove old config
sudo rm -rf /etc/nixos/*
```

4. Create a symlink from the downloaded folder to `/etc/nixos`
```bash
sudo ln -s nixos_rice/* /etc/nixos/
```

5. Rebuild the system
```
cd nixos_rice
sudo nixos-rebuild switch --flake .#nix
```

6. Reboot and enjoy!

## Things to do
update more configs
update bspwmrc to the current monitor, rn using -d, not good enough

thx for ur reading :)
