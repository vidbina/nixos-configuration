CUSTOM_SRCS=-I nixos=${HOME}/nixpkgs/nixos -I nixpkgs=${HOME}/nixpkgs

NIXOS_REBUILD=sudo nixos-rebuild

setup:
	sudo cp -r *.nix eid /etc/nixos/.

local-test:
	${NIXOS_REBUILD} ${CUSTOM_SRCS} test

local-switch:
	${NIXOS_REBUILD} ${CUSTOM_SRCS} switch

test:
	${NIXOS_REBUILD} test

switch:
	${NIXOS_REBUILD} switch

PSEUDO:
	local-switch local-test setup switch test
