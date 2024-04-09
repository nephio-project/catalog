# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2024 The Nephio Authors.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

DOCKER_CMD ?= $(shell which docker 2> /dev/null || which podman 2> /dev/null || echo docker)

.PHONY: fmt
fmt:
	sudo -E $(DOCKER_CMD) run --rm -u "$$(id -u):$$(id -g)" \
	-v "$$(pwd):/mnt" \
	-w /mnt mvdan/shfmt -l -w -i 4 -s .
	[ -f yamlfmt ] || curl -s "https://i.jpillora.com/google/yamlfmt" | bash
	./yamlfmt -dstar **/*.{yaml,yml}
