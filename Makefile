# Makefile
# BSD make required.

SETUP_SCRIPT := main.sh

all: install tests

install:
	@sh $(SETUP_SCRIPT)

tests:
	@echo "debug"

.PHONY: all install tests

