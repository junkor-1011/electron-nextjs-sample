MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all

.PHONY: all build-linux build-win build clean help

ELECTRON_SRCDIR := electron-src
RENDERER_SRCDIR := renderer
DIST_DIR := dist

SRCS := $(wildcard $(ELECTRON_SRCDIR)/*) $(wildcard $(RENDERER_SRCDIR)/*.ts) $(wildcard $(RENDERER_SRCDIR)/*.tsx) $(wildcard $(RENDERER_SRCDIR)/*.css) $(wildcard $(RENDERER_SRCDIR)/*.scss) 

COMPILED := $(wildcard main/*.js) $(wildcard renderer/out/*)

$(COMPILED): $(SRCS)
	pnpm build

build: $(COMPILED) ## build binary file

UNPACKED_LINUX := dist/linux-unpacked/example-app
$(UNPACKED_LINUX): $(COMPILED) $(SRCS)
	pnpm pack-app

build-linux: $(UNPACKED_LINUX)

UNPACKED_WIN := dist/win-unpacked/ElectronTypescriptNext.exe
$(UNPACKED_WIN): $(COMPILED) $(SRCS)
	docker compose run builder bash -c "pnpm electron-builder --win --dir"

build-win: $(UNPACKED_WIN)

all: build-linux build-win

run: ## run app
	@pnpm dev

clean: ## cleanup binary
	rm -rf main
	rm -rf renderer/.next
	rm -rf renderer/out
	rm -rf dist
	rm -rf node_modules

help: ## Print this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
