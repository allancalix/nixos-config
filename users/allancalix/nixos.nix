{ pkgs, ... }:

{
  users.users.allancalix = {
    isNormalUser = true;
    home = "/home/allancalix";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.fish;
    hashedPassword = "$6$6A17qEycGGb/9oZ$5MA3VTCXGcUQCqCCtC700fMjKLnl9Q0/.r4njMUjAYAAnlRQC8PiD8jUuoDKIL3LHVXeP7b1L4ADvgzRlyINI1";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCjzfDffI2nY2Bhhzbx8wqvyGkADRQ+yDAvlum/JdLuh4H6peERQtsUA0rQKSHurCybXXxy+8Thrg38GmA4l6FklfvXjqimecj7iD+X6QsqWPGoe21pNaev1OB3/kNUSHYKfTzOo0gioUQa2ubl8Nz5om/iFlYedofCnEUfGKZq6gVRrNeZVVsJ9qO8NqSrWyFlCkb7CVvVEeKez3BAxAjyxPHlpHFdPZ+DRB3NtMDrQww2Qkm9O0i2fKJ/8WYEcgiSzKuBplDL3tnEhCyqMXA+HBYpmGwPoG6o+D6dUQ5TR3n53z9ei21IO4DnEx0ne1ySKIbYkYGhbspSziKhGW8nqt8WnaGgvpbVt9ISBYBwNTgZW6DK0jK52ObA306rbB+0DM7uqraRuWn/Fxzi9B0UoLyiDsIKikx3nMv1ti+K1yw8sbJWs+ooKytHvzOGRc0VF9p73D/f5QpJWFgV3df6J5DmJEKjZEVOIs/0VObPxj34VGZzCZSzmcsdjn6csYvlseMRnuizpA36b9gmwlu4/oVRTaJIabHSSbRRgLSNWKoo6qu1h8VTAPbCAuAb6Y9yzTG8IfBG8uE9I5DiY70uGWUGDj2Dldkj6Vbd40dVVodz9hrLFgYg5kihMqNeV5tEN5u2S0F/JlHujp1Yno7K872vPtekjSpXpePIqLTl1w== allan@acx.dev"
    ];
  };

  nixpkgs.overlays = import ../../lib/overlays.nix ++ [
    (import ./vim.nix)
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/1dd99a6c91b4a6909e66d0ee69b3f31995f38851.tar.gz;
      sha256 = "1z8gx1cqd18s8zgqksjbyinwgcbndg2r6wv59c4qs24rbgcsvny9";
    }))
  ];
}
