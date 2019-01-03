HOME_MANAGER_REF     ?= refs/heads/master
KALBASIT_NUR_REF     ?= refs/heads/master
NIXOS_HARDWARE_REF   ?= refs/heads/master
NIXPKGS_UNSTABLE_REF ?= refs/heads/nixos-unstable
NIXPKGS_STABLE_REF   ?= refs/heads/nixos-18.09
NUR_REF              ?= refs/heads/master

.PHONY: all
all: build

.PHONY: build
build:
	NIX_PATH= nixos-rebuild -I nixpkgs=$(shell pwd)/external/nixpkgs-stable.nix -I nixos-config=$(shell pwd)/hosts/$(shell hostname -s)/configuration.nix build --show-trace

.PHONY: test
test:
	sudo -i nixos-rebuild -I nixos-config=$(shell pwd)/hosts/$(shell hostname -s)/configuration.nix test

# switch is not allowed to specify nixos-config as only the base repo (not any
# of the git worktrees) may switch the system
.PHONY: switch
switch:
	sudo -i nixos-rebuild switch

# boot is not allowed to specify nixos-config as only the base repo (not any
# of the git worktrees) may switch the system
.PHONY: boot
boot:
	sudo -i nixos-rebuild boot

.PHONY: brew
brew:
	brew bundle --file=os-specific/darwin/Brewfile

.PHONY: update-external
update-external: update-home-manager update-nixpkgs-stable update-nixpkgs-unstable update-nixos-hardware update-nur update-kalbasit-nur

.PHONY: update-home-manager
update-home-manager:
	$(shell pwd)/scripts/nix-prefetch-git.sh https://github.com/rycee/home-manager.git "$(HOME_MANAGER_REF)" | tee tmp
	mv tmp external/home-manager-version.json

.PHONY: update-nixpkgs-stable
update-nixpkgs-stable:
	$(shell pwd)/scripts/nix-prefetch-git.sh https://github.com/NixOS/nixpkgs-channels.git "$(NIXPKGS_STABLE_REF)" | tee tmp
	mv tmp external/nixpkgs-stable-version.json

.PHONY: update-nixpkgs-unstable
update-nixpkgs-unstable:
	$(shell pwd)/scripts/nix-prefetch-git.sh https://github.com/NixOS/nixpkgs-channels.git "$(NIXPKGS_UNSTABLE_REF)" | tee tmp
	mv tmp external/nixpkgs-unstable-version.json

.PHONY: update-nixos-hardware
update-nixos-hardware:
	$(shell pwd)/scripts/nix-prefetch-git.sh https://github.com/NixOS/nixos-hardware.git "$(NIXOS_HARDWARE_REF)" | tee tmp
	mv tmp external/nixos-hardware-version.json

.PHONY: update-nur
update-nur:
	$(shell pwd)/scripts/nix-prefetch-git.sh https://github.com/nix-community/NUR.git "$(NUR_REF)" | tee tmp
	mv tmp external/nur-version.json

.PHONY: update-kalbasit-nur
update-kalbasit-nur:
	$(shell pwd)/scripts/nix-prefetch-git.sh https://github.com/kalbasit/nur-packages.git "$(KALBASIT_NUR_REF)" | tee tmp
	mv tmp external/kalbasit-nur-version.json
