{ pkgs, ... }:

with pkgs;
{
  programs.vscode.extensions = with vscode-extensions; [
    elixir-lsp.vscode-elixir-ls
    bradlc.vscode-tailwindcss
  ] ++ vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "phoenix";
      publisher = "phoenixframework";
      version = "0.1.1";
      sha256 = "sha256-AfCwU4FF8a8C9D6+lyUDbAOLlD5SpZZw8CZVGpzRoV0=";
    }
    # {
    #   name = "vscode-elixir-snippets";
    #   publisher = "florinpatrascu";
    #   version = "0.2.37";
    #   sha256 = "05m1wkw34zzd7j0hgl8hdvy3dnn0q4cf83apg1d2nn3z478zid1i";
    # }
    # {
    #   name = "elixir-test";
    #   publisher = "samuel-pordeus";
    #   version = "1.7.1";
    #   sha256 = "Z467J7DSQagfooWH124fGvpdmG//NHwG44TiXOsyP3E=";
    # }
  ];
}
