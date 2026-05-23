#!/bin/bash

nix flake update
nix flake update nixpkgs
sudo nixos-rebuild switch --flake .
