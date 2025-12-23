{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
      # ----- Vim specifics -----
      lua-language-server
      prettierd
      nodePackages_latest.prettier
      stylua
      isort
      black
      pylint
      eslint_d
      shellcheck
      shfmt
      markdownlint-cli2
      github-markdown-toc-go
      typescript-language-server
      vscode-langservers-extracted
      tailwindcss-language-server
      svelte-language-server
      lua-language-server
      graphql-language-service-cli
      emmet-language-server
      pyright
      ruff
      marksman
      rust-analyzer
      yaml-language-server
      beautysh
  ];
}
