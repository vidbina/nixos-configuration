# Commands
CP=cp
NIXOS_REBUILD=nixos-rebuild --show-trace
SUDO=sudo

# Git repository and branch in which I keep the nixpkgs which I want to install
#
#		The MY_NIXPKGS_* variables are only used in the remote rules (remote-test
#		and remote-switch). Defining MY_NIXPKGS_REPO and/or MY_NIXPKGS_COMMIT prior
#		to invoking any of the "remote" rules will override the default values of
#		the following variables:
MY_NIXPKGS_REPO?=https://github.com/vidbina/nixpkgs

# Output of `git describe --dirty --always`
MY_NIXPKGS_COMMIT?=20.09-1982-g60b18a066e8

# Path to my nixpkgs
MY_NIXPKGS_PATH=${HOME}/nixpkgs

# Command arguments in case I want to build against $HOME/nixpkgs
MY_NIXPKGS_LOCAL_ARGS=-I nixos=${MY_NIXPKGS_PATH}/nixos -I nixpkgs=${MY_NIXPKGS_PATH}

# Sets up /etc/nixos and performs a switch
#
# 	In order to perform an upgrade when just using the default rule, one would
# 	have to explicitly call
#
# 		sudo nix-channel --upgrade nixos
#
#		in order to first trigger an upgrade of version of the nixos channel that
#		your system tracks.
all: setup switch

# Sets up the configuration in /etc/nixos
#
# 	Source: https://nixos.org/nixos/manual/index.html#sec-changing-config
setup:
	${SUDO} ${RM} -r /etc/nixos/customPkgs /etc/nixos/config
	${SUDO} ${CP} -Lr *.nix zsh customPkgs config /etc/nixos/.

# Performs nixos-rebuilds against the nixpkgs version of this system
#
# 	Unless you add packages using these rules, nothing should really change
# 	about your system you still use the exact same version of what you were
# 	already using
test:
	${SUDO} ${NIXOS_REBUILD} test

switch:
	${SUDO} ${NIXOS_REBUILD} switch

# Performs nixos-rebuilds against the upgraded nixpkgs
#
# 	The --upgrade flag basically facilitates an upgrade to the latest version
# 	of your selected channel. The benefit of this approach is that this always
# 	yields the latest version of the given release (e.g.: 17.09 or 17.09-small)
# 	but the downside is that is offers less control in version management of
# 	the packages involved. Any of these make rules can potentially trigger a
# 	lot of downloads and subsequent version upgrades of packages, perhaps this
# 	operation even breaks the configuration as packages get dropped or renamed.
upgrade-test:
	${SUDO} ${NIXOS_REBUILD} test --upgrade

upgrade-switch:
	${SUDO} ${NIXOS_REBUILD} switch --upgrade

# Performs nixos-rebuilds against a local clone of nixpkgs
#
# 	The local rules facilitate nixos-rebuilds against a local clone of the
# 	nixpkgs repository. This allows for the addition of packages to nixpkgs and
# 	referencing them in the nixos-configuration without having to push them
# 	upstream first.
#
# 	Source: https://nixos.org/nixos/manual/#sec-changing-config
local-boot:
	${SUDO} ${NIXOS_REBUILD} ${MY_NIXPKGS_LOCAL_ARGS} boot

local-test:
	${SUDO} ${NIXOS_REBUILD} ${MY_NIXPKGS_LOCAL_ARGS} test

local-switch:
	${SUDO} ${NIXOS_REBUILD} ${MY_NIXPKGS_LOCAL_ARGS} switch

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
remote-test:
	${SUDO} ${NIXOS_REBUILD} -I nixpkgs=${MY_NIXPKGS_REPO}/archive/${MY_NIXPKGS_COMMIT}.tar.gz test

remote-switch:
	${SUDO} ${NIXOS_REBUILD} -I nixpkgs=${MY_NIXPKGS_REPO}/archive/${MY_NIXPKGS_COMMIT}.tar.gz switch

.PHONY: all test \
	setup \
	switch \
	local-test local-switch \
	remote-test remote-switch \
	upgrade-test upgrade-switch
