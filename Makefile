CUSTOM_SRCS=-I nixos=${HOME}/nixpkgs/nixos -I nixpkgs=${HOME}/nixpkgs

NIXOS_REBUILD=sudo nixos-rebuild

# Git repository and branch in which I keep the nixpkgs which I want to install
MY_NIXPKGS_REPO?=https://github.com/vidbina/nixpkgs
MY_NIXPKGS_BRANCH?=current

setup:
	sudo cp -r *.nix eid /etc/nixos/.

local-test:
	${NIXOS_REBUILD} ${CUSTOM_SRCS} test

local-switch:
	${NIXOS_REBUILD} ${CUSTOM_SRCS} switch

remote-test:
	${NIXOS_REBUILD} -I nixpkgs=${MY_NIXPKGS_REPO}/archive/${MY_NIXPKGS_BRANCH}.tar.gz test

remote-switch:
	${NIXOS_REBUILD} -I nixpkgs=${MY_NIXPKGS_REPO}/archive/${MY_NIXPKGS_BRANCH}.tar.gz switch

test:
	${NIXOS_REBUILD} test

switch:
	${NIXOS_REBUILD} switch

PSEUDO:
	local-switch local-test setup switch test
