let
  thinknix-markus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOvLFmp9FQ6rI8FWjxbia/ddGJBGjEdczyGtI8NqKGpn markus@markus-nixos";
  thinknix = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBICxcnUgDpM9VDMWV0bBeBmJr2hUJ+E4gSZJwYjWWsw root@markus-nixos";
  nixpad-markus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEwGwmrgTrl474NM36MNH/oR+QodDZEwz7jailOnoUQo markus@markus-nixos";
  nixpad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOVioAqB05gkclIgb5uyBuBs9TJE0FxNmvHjFTjUKo9M root@markus-nixos";
  all = [ thinknix thinknix-markus nixpad nixpad-markus ];
in
{
  "sourcegraph.age".publicKeys = all;
}
