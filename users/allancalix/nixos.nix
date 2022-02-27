{ pkgs, ... }:

{
  users.users.allancalix = {
    isNormalUser = true;
    home = "/home/allancalix";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.fish;
    hashedPassword = "$6$Q9rHJ4BXa/aC3iMS$HYuEd0U5NOkvjBD6G3FcJ1Jo13dyBKbtj8lLa2FgmCQN.K7sUIqdzh74GXh1Yk21dcQ68NZHJXgZsxaCPXZyh0";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCjzfDffI2nY2Bhhzbx8wqvyGkADRQ+yDAvlum/JdLuh4H6peERQtsUA0rQKSHurCybXXxy+8Thrg38GmA4l6FklfvXjqimecj7iD+X6QsqWPGoe21pNaev1OB3/kNUSHYKfTzOo0gioUQa2ubl8Nz5om/iFlYedofCnEUfGKZq6gVRrNeZVVsJ9qO8NqSrWyFlCkb7CVvVEeKez3BAxAjyxPHlpHFdPZ+DRB3NtMDrQww2Qkm9O0i2fKJ/8WYEcgiSzKuBplDL3tnEhCyqMXA+HBYpmGwPoG6o+D6dUQ5TR3n53z9ei21IO4DnEx0ne1ySKIbYkYGhbspSziKhGW8nqt8WnaGgvpbVt9ISBYBwNTgZW6DK0jK52ObA306rbB+0DM7uqraRuWn/Fxzi9B0UoLyiDsIKikx3nMv1ti+K1yw8sbJWs+ooKytHvzOGRc0VF9p73D/f5QpJWFgV3df6J5DmJEKjZEVOIs/0VObPxj34VGZzCZSzmcsdjn6csYvlseMRnuizpA36b9gmwlu4/oVRTaJIabHSSbRRgLSNWKoo6qu1h8VTAPbCAuAb6Y9yzTG8IfBG8uE9I5DiY70uGWUGDj2Dldkj6Vbd40dVVodz9hrLFgYg5kihMqNeV5tEN5u2S0F/JlHujp1Yno7K872vPtekjSpXpePIqLTl1w== allan@acx.dev"
    ];
  };
}
