TARGETS := $(shell ls scripts)

.dapper:
	@echo Downloading dapper
	@curl -sL https://releases.rancher.com/dapper/latest/dapper-$$(uname -s)-$$(uname -m) > .dapper.tmp
	@@chmod +x .dapper.tmp
	@./.dapper.tmp -v
	@mv .dapper.tmp .dapper

$(TARGETS): .dapper
	./.dapper $@

build:
	docker build \
		-t ghcr.io/t-young31/harvester-seeder:dev \
		-f package/Dockerfile \
		.

.DEFAULT_GOAL := ci

.PHONY: $(TARGETS)
