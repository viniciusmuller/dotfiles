{ username, ... }:

{
  virtualisation.docker = {
    enable = true;
    extraOptions = ''
      --insecure-registry "http://registry:5000"
    '';
  };
  users.users.${username}.extraGroups = [ "docker" ];
}
