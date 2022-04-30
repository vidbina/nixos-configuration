SHELL = /usr/bin/env bash

# Commands
CP = cp
NIXOS_REBUILD = nixos-rebuild
RM = rm
RSYNC = rsync
SUDO = sudo

# Git repository and branch in which I keep the nixpkgs which I want to install
#
#		The MY_NIXPKGS_* variables are only used in the remote rules (remote-test
#		and remote-switch). Defining MY_NIXPKGS_REPO and/or MY_NIXPKGS_COMMIT prior
#		to invoking any of the "remote" rules will override the default values of
#		the following variables:
MY_NIXPKGS_REPO ?= "https://github.com/vidbina/nixpkgs"

# Output of `git describe --dirty --always`
# TODO: Update manually to maintain a ref to the last working installation
MY_NIXPKGS_COMMIT ?= "21.05-1432-g4feab93d28e"


.PHONY: version
version:
	@cd "$(MY_NIXPKGS_PATH)" && git describe --dirty --always


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
.PHONY: nonflake
nonflake: nonflake-setup nonflake-switch

# Sets up the configuration in /etc/nixos
#
# 	Source: https://nixos.org/nixos/manual/index.html#sec-changing-config
.PHONY: nonflake-setup
nonflake-setup:
	@$(SUDO) $(RSYNC) -avr --exclude='flake*' --exclude='customPkgs/' --exclude='tmp/*' --exclude='.git/*' --exclude 'result' . /tmp/nixos

# TODO: Add --flake '.#TARGET' --verbose helper

# Performs nixos-rebuilds against the nixpkgs version of this system
#
# 	Unless you add packages using these rules, nothing should really change
# 	about your system you still use the exact same version of what you were
# 	already using
.PHONY: nonflake-test
nonflake-test:
	@$(SUDO) $(NIXOS_REBUILD) test $(NIXOS_REBUILD_ARGS)

.PHONY: nonflake-switch
nonflake-switch:
	@$(SUDO) $(NIXOS_REBUILD) switch $(NIXOS_REBUILD_ARGS)

# Performs nixos-rebuilds against the upgraded nixpkgs
#
# 	The --upgrade flag basically facilitates an upgrade to the latest version
# 	of your selected channel. The benefit of this approach is that this always
# 	yields the latest version of the given release (e.g.: 17.09 or 17.09-small)
# 	but the downside is that is offers less control in version management of
# 	the packages involved. Any of these make rules can potentially trigger a
# 	lot of downloads and subsequent version upgrades of packages, perhaps this
# 	operation even breaks the configuration as packages get dropped or renamed.
.PHONY: nonflake-upgrade-test
nonflake-upgrade-test:
	@$(SUDO) $(NIXOS_REBUILD) test --upgrade $(NIXOS_REBUILD_ARGS)

.PHONY: nonflake-upgrade-switch
nonflake-upgrade-switch:
	@$(SUDO) $(NIXOS_REBUILD) switch --upgrade $(NIXOS_REBUILD_ARGS)

# Performs nixos-rebuilds against a local clone of nixpkgs
#
# 	The local rules facilitate nixos-rebuilds against a local clone of the
# 	nixpkgs repository. This allows for the addition of packages to nixpkgs and
# 	referencing them in the nixos-configuration without having to push them
# 	upstream first.
#
# 	Source: https://nixos.org/nixos/manual/#sec-changing-config
.PHONY: nonflake-local-boot
nonflake-local-boot:
	@$(SUDO) $(NIXOS_REBUILD) $(MY_NIXPKGS_LOCAL_ARGS) boot $(NIXOS_REBUILD_ARGS)

.PHONY: nonflake-local-test
nonflake-local-test:
	@$(SUDO) $(NIXOS_REBUILD) $(MY_NIXPKGS_LOCAL_ARGS) test $(NIXOS_REBUILD_ARGS)

.PHONY: nonflake-local-switch
nonflake-local-switch:
	@$(SUDO) $(NIXOS_REBUILD) $(MY_NIXPKGS_LOCAL_ARGS) switch $(NIXOS_REBUILD_ARGS)

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
.PHONY: nonflake-remote-test
nonflake-remote-test:
	@$(SUDO) $(NIXOS_REBUILD) \
		-I nixpkgs="$(MY_NIXPKGS_REPO)/archive/$(MY_NIXPKGS_COMMIT).tar.gz" test \
		$(NIXOS_REBUILD_ARGS)

.PHONY: nonflake-remote-switch
nonflake-remote-switch:
	@$(SUDO) $(NIXOS_REBUILD) \
		-I nixpkgs="$(MY_NIXPKGS_REPO)/archive/$(MY_NIXPKGS_COMMIT).tar.gz" switch \
		$(NIXOS_REBUILD_ARGS)
