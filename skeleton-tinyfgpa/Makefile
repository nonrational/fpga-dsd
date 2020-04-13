# needed for `source`
SHELL := /bin/bash

all: lint build

build:
	apio build -v

clean:
	apio clean -v

lint:
	apio lint --top top

program: all
	apio upload -v

test: lint verify
	source .env && apio sim

update-bootloader:
	tinyprog --update-bootloader

enable-serial-drivers:
	test -s .apio-drivers-serial-enabled || (apio drivers --serial-enable && date > .apio-drivers-serial-enabled)

verify:
	apio verify


.PHONY: all build clean lint program test
