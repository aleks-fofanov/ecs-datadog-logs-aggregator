SHELL := /bin/bash

# List of targets the `readme` target should call before generating the readme
export README_DEPS ?= docs/targets.md

-include $(shell curl -sSL -o .build-harness "https://git.io/build-harness"; echo .build-harness)

readme/sync: # Aka build with custom template
	README_TEMPLATE_FILE=$(shell pwd)/templates/README.md $(SELF) readme/build
