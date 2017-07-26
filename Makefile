setup:
	sudo cp -r *.nix eid /etc/nixos/.

test:
	sudo nixos-rebuild test

install:
	sudo nixos-rebuild switch

PSEUDO:
	setup
