SHELL = /usr/bin/env bash

# Commands
CP = "cp"
NIXOS_REBUILD = "$(shell sudo nixos-rebuild --show-trace)"
RM = "rm"

# Git repository and branch in which I keep the nixpkgs which I want to install
#
#		The MY_NIXPKGS_* variables are only used in the remote rules (remote-test
#		and remote-switch). Defining MY_NIXPKGS_REPO and/or MY_NIXPKGS_COMMIT prior
#		to invoking any of the "remote" rules will override the default values of
#		the following variables:
MY_NIXPKGS_REPO ?= "https://github.com/vidbina/nixpkgs"

# Output of `git describe --dirty --always`
# Update manually to maintain a tracked ref to the last working installation
MY_NIXPKGS_COMMIT ?= "20.09-2033-g12d9950bf47"

.PHONY: version
version:
	cd "$(MY_NIXPKGS_PATH)" && git describe --dirty --always


# Path to my nixpkgs
MY_NIXPKGS_PATH = $(HOME)/nixpkgs

# Command arguments in case I want to build against $HOME/nixpkgs
MY_NIXPKGS_LOCAL_ARGS = -I nixos="$(MY_NIXPKGS_PATH)/nixos" -I nixpkgs="$(MY_NIXPKGS_PATH)"

# Sets up /etc/nixos and performs a switch
#
# 	In order to perform an upgrade when just using the default rule, one would
# 	have to explicitly call
#
# 		sudo nix-channel --upgrade nixos
#
#		in order to first trigger an upgrade of version of the nixos channel that
#		your system tracks.
.PHONY: all
all: setup switch

# Sets up the configuration in /etc/nixos
#
# 	Source: https://nixos.org/nixos/manual/index.html#sec-changing-config
.PHONY: setup
setup:
	$(RM) -r /etc/nixos/customPkgs /etc/nixos/config
	$(CP) -Lr "*.nix" zsh customPkgs config /etc/nixos/.

# Performs nixos-rebuilds against the nixpkgs version of this system
#
# 	Unless you add packages using these rules, nothing should really change
# 	about your system you still use the exact same version of what you were
# 	already using
.PHONY: test
test:
	$(NIXOS_REBUILD) test

.PHONY: switch
switch:
	$(NIXOS_REBUILD) switch

# Performs nixos-rebuilds against the upgraded nixpkgs
#
# 	The --upgrade flag basically facilitates an upgrade to the latest version
# 	of your selected channel. The benefit of this approach is that this always
# 	yields the latest version of the given release (e.g.: 17.09 or 17.09-small)
# 	but the downside is that is offers less control in version management of
# 	the packages involved. Any of these make rules can potentially trigger a
# 	lot of downloads and subsequent version upgrades of packages, perhaps this
# 	operation even breaks the configuration as packages get dropped or renamed.
.PHONY: upgrade-test
upgrade-test:
	$(NIXOS_REBUILD) test --upgrade

.PH0NY: upgrade-switch
upgrade-switch:
	$(NIXOS_REBUILD) switch --upgrade

# Performs nixos-rebuilds against a local clone of nixpkgs
#
# 	The local rules facilitate nixos-rebuilds against a local clone of the
# 	nixpkgs repository. This allows for the addition of packages to nixpkgs and
# 	referencing them in the nixos-configuration without having to push them
# 	upstream first.
#
# 	Source: https://nixos.org/nixos/manual/#sec-changing-config
.PHONY: local-boot
local-boot:
	$(NIXOS_REBUILD) $(MY_NIXPKGS_LOCAL_ARGS) boot

.PHONY: local-test
local-test:
	$(NIXOS_REBUILD) $(MY_NIXPKGS_LOCAL_ARGS) test

.PHONY: local-switch
local-switch:
	$(NIXOS_REBUILD) $(MY_NIXPKGS_LOCAL_ARGS) switch

# Performs nixos-rebuilds against a remote nixpkgs
#
# 	The remote rules facilitate nixos-rebuilds against an repository archive as
# 	indicated by MY_NIXPKGS_REPO. By maintaining the branch as specified by
# 	MY_NIXPKGS_COMMIT, one can provide an online nixpkgs archive that should
# 	result to identical package versions between all machines that
# 	nixos-rebuild against this archive.
#
# 	NOTE: When a change is made to the specified branch, one should invoke
# 	these rules on all the machines that are build against the branch in order
# 	to ensure package version parity between machines.
.PHONY: remote-test
remote-test:
	$(NIXOS_REBUILD) -I nixpkgs="$(MY_NIXPKGS_REPO)/archive/$(MY_NIXPKGS_COMMIT).tar.gz" test

.PHONY: remote-switch
remote-switch:
	$(NIXOS_REBUILD) -I nixpkgs="$(MY_NIXPKGS_REPO)/archive/$(MY_NIXPKGS_COMMIT).tar.gz" switch
