let
    thinknix-markus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOvLFmp9FQ6rI8FWjxbia/ddGJBGjEdczyGtI8NqKGpn markus@markus-nixos";
    thinknix = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBICxcnUgDpM9VDMWV0bBeBmJr2hUJ+E4gSZJwYjWWsw root@markus-nixos";
    all = [ thinknix thinknix-markus ];
in
{
    "sourcegraph.age".publicKeys = all;
}
