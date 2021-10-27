{ pkgs, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$1" "$@"
  '';
in
{
  environment.systemPackages = [
    nvidia-offload
  ];

  services.xserver.config = ''
    # Integrated Intel GPU
    Section "Device"
      Identifier "iGPU"
      Driver "modesetting"
    EndSection

    # Dedicated NVIDIA GPU
    Section "Device"
      Identifier "dGPU"
      Driver "nvidia"
    EndSection

    Section "ServerLayout"
      Identifier "layout"
      Screen 0 "iGPU"
    EndSection

    Section "Screen"
      Identifier "iGPU"
      Device "iGPU"
    EndSection
  '';

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.prime = {
    offload.enable = true;

    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    intelBusId = "PCI:0:2:0";

    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    nvidiaBusId = "PCI:1:0:0";
  };
}
