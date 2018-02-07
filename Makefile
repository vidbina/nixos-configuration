# Commands
CP=cp
NIXOS_REBUILD=nixos-rebuild
SUDO=sudo

# Command arguments in case I want to build against $HOME/nixpkgs
MY_NIXPKGS_LOCAL_ARGS=-I nixos=${HOME}/nixpkgs/nixos -I nixpkgs=${HOME}/nixpkgs

# Git repository and branch in which I keep the nixpkgs which I want to install
MY_NIXPKGS_REPO?=https://github.com/vidbina/nixpkgs
MY_NIXPKGS_BRANCH?=current

# Sets up /etc/nixos for installation
setup:
	${SUDO} ${CP} -r *.nix eid /etc/nixos/.

# https://nixos.org/nixos/manual/#sec-changing-config
local-test:
	${SUDO} ${NIXOS_REBUILD} ${MY_NIXPKGS_LOCAL_ARGS} test

local-switch:
	${SUDO} ${NIXOS_REBUILD} ${MY_NIXPKGS_LOCAL_ARGS} switch

remote-test:
	${SUDO} ${NIXOS_REBUILD} -I nixpkgs=${MY_NIXPKGS_REPO}/archive/${MY_NIXPKGS_BRANCH}.tar.gz test

remote-switch:
	${SUDO} ${NIXOS_REBUILD} -I nixpkgs=${MY_NIXPKGS_REPO}/archive/${MY_NIXPKGS_BRANCH}.tar.gz switch

test:
	${SUDO} ${NIXOS_REBUILD} test

switch:
	${SUDO} ${NIXOS_REBUILD} switch

.PHONY:
	setup \
	switch test \
	local-test local-switch \
	remote-test remote-switch
