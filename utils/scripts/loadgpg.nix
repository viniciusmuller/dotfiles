{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "loadgpg" ''
      key=$(bw unlock --raw)

      private=~/private.gpg
      public=~/public.gpg

      for i in {1..3}; do
        bw get item GPG_PRIV"$i" --session "$key" | jq -r '.notes' >> "$private"
      done

      bw get item GPG_PUB --session "$key" | jq -r '.notes' > "$public"

      bw lock
    '')
    pkgs.jq
  ];
}
