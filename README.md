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

> In both `nixos-rebuild test` as in `nixos-rebuild switch` all changes are actually installed. The only difference is that `nixos-rebuild switch` persists the changes by adding a new generation that shows up in the bootlist. In the test case the installed changes are in your nixos store until you clean it up. This is why subsequent `nixos-rebuild` operations is so much faster -- a lot of data is cached from a previous build. :wink:

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
