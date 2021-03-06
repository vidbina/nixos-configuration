# NixOS :snowflake: configuration

This is the NixOS :snowflake: configuration that I use on my Dell XPS.

# Usage

> :bulb: Last update was tested with `make setup && make remote-test` and
> applied with `make setup && make remote-switch`. Just run this and be done
> with it. :wink:


This NixOS configuration comes packages with a collection of make rules that
are intended to make your life a little bit easier. The installation process
for a NixOS configuration requires the making of changes to `/etc/nixos`
followed by the installation of the given configuration by `nixos-rebuild test`
or `nixos-rebuild switch`. Testing a configuration is convenient to test
changes that you aren't sure you may want to persist yet. After playing around
with the new configuration for a while one can persist the changes by running a
switch operations. :wink:

# Enable Overlays

By simlinking the overlays directory to ~/.config/nixpkgs/overlays.

> In both `nixos-rebuild test` as in `nixos-rebuild switch` all changes are
> actually installed. The only difference is that `nixos-rebuild switch`
> persists the changes by adding a new generation that shows up in the
> bootlist. In the test case the installed changes are in your nixos store
> until you clean it up. This is why subsequent `nixos-rebuild` operations are
> much faster -- a lot of data is cached from a previous build. :wink:

### The easy way

Run
 - `make` to setup the configuration in /etc/nixos and `nixos-rebuild switch`
   to it, making it permanent :wink:
 - profit :trophy:

### The harder way

Run
 - `make setup` to copy the configuration to `/etc/nixos`
 - `make test` to install the configuration without producing a generation such
   that all changes are generally undone after reboot
 - `make switch` to commit the configuration to a generation such that all
   changes will still be around after a reboot :wink:
 - profit :moneybag:

### Details

The Makefile essentially describes 3 types of make rules:
 - `setup` rule sets up the `/etc/nixos` directory to be able to run
   `nixos-rebuild` at a later stage
 - `test` rules perform a `nixos-rebuild` without committing it to the
   generations
 - `switch` rules perform a `nixos-rebuild` and commit it to the generations

of which "test" and "switch" rules take the following form:
 - `test` and `switch`, referred to as the "basic" or "vanilla" rules
 - `local-test` and `local-switch`, referred to as the "local" rules
 - `remote-test` and `remote-switch`, referred to as the "remote" rules
 - `upgrade-test` and `upgrade-switch`, referred to as the "upgrade" rules

Note that the vanilla rules (`test` and `switch`) are basically performed
against the nixpkgs version of your system's selected channel (see
`nixos-version --revision`).  This could be updated by executing `sudo
nix-channel --upgrade nixos`.

Conversely, if you don't want to think about manually upgrading, you could use
the `upgrade-test` and `upgrade-switch` rules which will install against the
latest version of your selected channel. Between different nixos-rebuild
operations, one should expect that occasionally packages can be removed or
renamed thus resulting to failing builds, but this should be simple to fix.

The `local-test` and `local-switch` rules are useful if you need to build
against a local clone of nixpkgs. This comes in handy when you've added,
altered or removed modules or packages in nixpkgs. When using this approach,
one should occasionally consider consolidating the updated upstream branch for
the given channel with the local repository (either through a merge and/or
rebase).

Finally, `remote-test` and `remote-switch` could be used to build against a
remote nixpkgs archive. This is convenient if you want to build your
configuration against a known endpoint between different machines. If the
remote endpoint is that of a branch, and you are not the maintainer of that
endpoint you will have to exercise the same caution that you practiced when
invoking `upgrade-test` or `upgrade-switch` rules since packages could be
removed or renamed between revisions.

## OpenVPN

In order to configure OpenVPN, override the `openvpn` configuration in net.nix
to comply with the following format:

```nix
{
  servers = {
    tcp-config-one = {
      autoStart = false;
      updateResolvConf = true;
      config = ''
        config /home/user/path/to/openvpn-config-for-one.ovpn
        auth-user-pass /path/to/myprovider-pass-file.txt
        '';
    };
  };
}
```

where the paths for config and auth-user-pass are updated to reflect
the paths of the files on your system.

Alternatively, leave the helpers defined in the `let` block of the openvpn
attribute in net.nix as is and provide a config/openvpn.nix file with the
configuration as follows:

```nix
{ toUpper }:
let
  regions = [
    ["de" "Germany"]
    ["nl" "Netherlands"]
    ["us-nyc" "USA-NEW-YORK"]
  ];
  builder = { region ? [], kind ? "tcp" }:
  let
    locationIdentifier = builtins.elemAt region 0;
    locationName = builtins.elemAt region 1;
  in {
    handle = "${toUpper(kind)}-${toUpper(locationIdentifier)}";
    configFile = "/home/user/path/to/${kind}-openvpn-config-for-${locationName}.ovpn";
    passFile = "/path/to/myprovider-pass-file.txt";
  };
in
  builtins.foldl' (acc: val: acc ++ [(builder {
    region = val;
    kind = "tcp";
  })]) [] regions ++
  builtins.foldl' (acc: val: acc ++ [(builder {
    region = val;
    kind = "udp";
  })]) [] regions
```

in order to dynamically generate your configuration in case you have many
configurations that share some common properties.

The example above, generates a configuration of the following OpenVPN
configurations with their corresponding .ovpn files:
 - `tcp-DE` at `/home/user/path/to/tcp-openvpn-config-for-Germany.ovpn`
 - `tcp-NL` at `/home/user/path/to/tcp-openvpn-config-for-Netherlands.ovpn`
 - `tcp-US-NYC` at `/home/user/path/to/tcp-openvpn-config-for-USA-NEW-YORK.ovpn`
 - `udp-DE` at `/home/user/path/to/udp-openvpn-config-for-Germany.ovpn`
 - `udp-NL` at `/home/user/path/to/udp-openvpn-config-for-Netherlands.ovpn`
 - `udp-US-NYC` at `/home/user/path/to/udp-openvpn-config-for-USA-NEW-YORK.ovpn`
where all configurations share the same passFile and naming scheme such that
we're able to derive the necessary attributes from a smaller collection of
inputs.

In summary, `config/openvpn.nix` contains a function that receives some
functions needed for the internal housekeeping and simply returns a list of
attrsets. In the provided example, we just needed to provide the `toUpper`
helper and then just fold over a list of regions to generate the list
for the helper in net.nix. In case this is just too messy for you, revert to
the instructions at the head of this paragraph for a much easier but possibly
more verbose setup. :wink:
