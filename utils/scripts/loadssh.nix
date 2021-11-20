{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "loadssh" ''
      key=$(bw unlock --raw)
      private=~/.ssh/id_ed25519
      public=~/.ssh/id_ed25519.pub

      mkdir -p ~/.ssh

      bw get item --session "$key" SSH_PRIV | jq -r '.notes' > "$private"
      bw get item --session "$key" SSH_PUB | jq -r '.notes' > "$public"

      bw lock

      chmod 600 "$private" "$public"
    '')
    pkgs.jq
    pkgs.bitwarden-cli
  ];
}
