{ pkgs, ... }:

# Important note: This configuration requires the `VT-D` feature to be enabled
# inside your BIOS.
let
  username = "vini";
in
{
  boot = {
    kernelParams = [
      # https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF#Setting_up_IOMMU
      "intel_iommu=on"
      "iommu=pt"

      # https://forums.unraid.net/topic/47345-performance-improvements-in-vms-by-adjusting-cpu-pinning-and-assignment/
      # "isolcpus=1,5,2,6,3,7,4,0"

      "pcie_aspm=off"
    ];

    kernelModules = [
      "kvm-intel"
      "vfio_pci"
      "vfio_iommu_type1"
      "vfio_virqfd"
      "vfio"
    ];

    blacklistedKernelModules = [
      "nvidia"
      "nouveau"
    ];

    extraModprobeConfig = "options vfio-pci ids=10de:1b81";

    postBootCommands = ''
      DEVS="0000:0f:00.0 0000:0f:00.1"

      for DEV in $DEVS; do
        echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
      done
      modprobe -i vfio-pci
    '';
  };

  services.udev.extraRules = ''
    # Symlink KMonad device
    ACTION=="add", ATTRS{name}=="KMonad output", SYMLINK+="KMONAD_DEVICE"
  '';

   # Pipewire + pulseaudio support (you can also use just pulseaudio)
   services.pipewire = {
     enable = true;
     pulse.enable = true;
   };

  # Scream
  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 ${username} qemu-libvirtd -"
  ];

  systemd.user.services.scream-network = {
    enable = true;
    description = "Scream network";
    serviceConfig = {
      ExecStart = "${pkgs.scream}/bin/scream -o pulse -i virbr0";
      Restart = "always";
    };
    wantedBy = [ "default.target" ];
    requires = [ "pipewire.service" ]; # Change to pulseaudio.service if using it
  };

  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu = {
      ovmf.enable = true;
      runAsRoot = false;
    };
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    looking-glass-client
  ];
}

