setup:
	sudo cp *.nix /etc/nixos/.

test:
	sudo nixos-rebuild test

install:
	sudo nixos-rebuild switch

PSEUDO:
	setup
