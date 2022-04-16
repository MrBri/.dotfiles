#!/bin/bash

# nvim :checkhealth doesn't seem to reconize pnpm
pnpm add -g pnpm neovim

pip install -U localstack pynvim pip awscli-local
