.PHONY: help test lint install dev-setup clean format check

# Default target
help:
	@echo "asdf-ghjk - Development Commands"
	@echo ""
	@echo "Available targets:"
	@echo "  make help       - Show this help message"
	@echo "  make test       - Run all tests"
	@echo "  make lint       - Run ShellCheck linting"
	@echo "  make check      - Run lint and tests"
	@echo "  make install    - Install plugin to asdf"
	@echo "  make dev-setup  - Set up development environment"
	@echo "  make format     - Format shell scripts (requires shfmt)"
	@echo "  make clean      - Clean up test artifacts"
	@echo ""

# Run tests
test:
	@echo "Running tests..."
	@./scripts/test.sh

# Run linting
lint:
	@echo "Running ShellCheck..."
	@shellcheck bin/* lib/*.sh scripts/*.sh

# Run both lint and tests
check: lint test
	@echo "All checks passed!"

# Install plugin to asdf
install:
	@echo "Installing plugin to asdf..."
	@if asdf plugin list | grep -q ghjk; then \
		echo "Removing existing plugin..."; \
		asdf plugin remove ghjk || true; \
	fi
	@asdf plugin add ghjk "$(PWD)"
	@echo "Plugin installed successfully!"

# Set up development environment
dev-setup:
	@./scripts/setup-dev.sh

# Format shell scripts (requires shfmt)
format:
	@if command -v shfmt >/dev/null 2>&1; then \
		echo "Formatting shell scripts..."; \
		shfmt -w -i 2 -ci bin/* lib/*.sh scripts/*.sh; \
	else \
		echo "shfmt not found. Install with: go install mvdan.cc/sh/v3/cmd/shfmt@latest"; \
		exit 1; \
	fi

# Clean up test artifacts
clean:
	@echo "Cleaning up..."
	@rm -rf test/bats test/bats-support test/bats-assert
	@rm -f test/*.log
	@rm -rf .env
	@echo "Clean complete!"

# Quick test individual script
test-list-all:
	@./bin/list-all

test-utils:
	@./test/bats/bin/bats test/utils.bats

test-download:
	@./test/bats/bin/bats test/download.bats

test-install:
	@./test/bats/bin/bats test/install.bats
