# Commands
CP=cp
NIXOS_REBUILD=nixos-rebuild

# Command arguments in case I want to build against $HOME/nixpkgs
MY_NIXPKGS_LOCAL_ARGS=-I nixos=${HOME}/nixpkgs/nixos -I nixpkgs=${HOME}/nixpkgs

# Git repository and branch in which I keep the nixpkgs which I want to install
MY_NIXPKGS_REPO?=https://github.com/vidbina/nixpkgs
MY_NIXPKGS_BRANCH?=current

# Sets up /etc/nixos for installation
setup:
	${CP} -r *.nix eid /etc/nixos/.

local-test:
	${NIXOS_REBUILD} ${MY_NIXPKGS_LOCAL_ARGS} test

local-switch:
	${NIXOS_REBUILD} ${MY_NIXPKGS_LOCAL_ARGS} switch

remote-test:
	${NIXOS_REBUILD} -I nixpkgs=${MY_NIXPKGS_REPO}/archive/${MY_NIXPKGS_BRANCH}.tar.gz test

remote-switch:
	${NIXOS_REBUILD} -I nixpkgs=${MY_NIXPKGS_REPO}/archive/${MY_NIXPKGS_BRANCH}.tar.gz switch

test:
	${NIXOS_REBUILD} test

switch:
	${NIXOS_REBUILD} switch

.PHONY:
	setup \
	switch test \
	local-test local-switch \
	remote-test remote-switch
