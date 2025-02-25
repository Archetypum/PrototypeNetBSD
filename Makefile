# Makefike
# BSD make required.

all: install tests

install:
	@sh $(SETUP_SCRIPT)

tests:
	@echo "debug"

.PHONY: all install tests

