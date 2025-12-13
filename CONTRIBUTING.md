# Contributing to asdf-ghjk

Thank you for your interest in contributing to asdf-ghjk! This document provides guidelines and information for contributors.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Making Changes](#making-changes)
- [Testing](#testing)
- [Submitting Changes](#submitting-changes)
- [Coding Standards](#coding-standards)
- [Release Process](#release-process)

## Code of Conduct

This project follows a standard code of conduct:

- Be respectful and inclusive
- Welcome newcomers and help them learn
- Focus on constructive criticism
- Assume good intentions

## Getting Started

### Prerequisites

- Git
- Bash 4.0+
- asdf version manager
- ShellCheck (for linting)
- BATS (for testing)

### Fork and Clone

1. Fork the repository on GitHub
2. Clone your fork:

```bash
git clone https://github.com/YOUR_USERNAME/asdf-ghjk.git
cd asdf-ghjk
```

3. Add upstream remote:

```bash
git remote add upstream https://github.com/Hyperpolymath/asdf-ghjk.git
```

## Development Setup

### Install Development Dependencies

```bash
# Install ShellCheck (linting)
# Ubuntu/Debian
sudo apt-get install shellcheck

# macOS
brew install shellcheck

# Install BATS (testing)
git clone https://github.com/bats-core/bats-core.git test/bats
git clone https://github.com/bats-core/bats-support.git test/bats-support
git clone https://github.com/bats-core/bats-assert.git test/bats-assert
```

### Set Up Testing Environment

```bash
# Add the plugin to your local asdf
asdf plugin add ghjk "$(pwd)"

# Test listing versions
asdf list all ghjk

# Test installing a version
asdf install ghjk latest
```

## Making Changes

### Branch Naming

Create a descriptive branch name:

```bash
git checkout -b feature/add-new-feature
git checkout -b fix/issue-123
git checkout -b docs/improve-readme
```

### Commit Messages

Follow conventional commit format:

```
type(scope): subject

body (optional)

footer (optional)
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `test`: Test changes
- `refactor`: Code refactoring
- `chore`: Maintenance tasks
- `ci`: CI/CD changes

**Examples:**

```
feat(download): add checksum verification

Implement SHA256 checksum verification for downloaded
ghjk binaries to ensure integrity.

Closes #42
```

```
fix(install): handle missing bin directory

Create bin directory if it doesn't exist during installation.

Fixes #15
```

## Testing

### Run Linting

```bash
# Lint all scripts
shellcheck bin/* lib/*.sh

# Lint specific file
shellcheck bin/download
```

### Run Tests

```bash
# Run all tests
./test/bats/bin/bats test/

# Run specific test file
./test/bats/bin/bats test/utils.bats

# Run with verbose output
./test/bats/bin/bats -t test/
```

### Manual Testing

```bash
# Set up test environment
export ASDF_INSTALL_VERSION="0.3.2"
export ASDF_DOWNLOAD_PATH="/tmp/asdf-ghjk-download"
export ASDF_INSTALL_PATH="/tmp/asdf-ghjk-install"

# Test download
./bin/download

# Test install
./bin/install

# Verify
/tmp/asdf-ghjk-install/bin/ghjk --version

# Clean up
rm -rf /tmp/asdf-ghjk-*
```

### Test Multiple Platforms

If possible, test on:
- Linux (x86_64)
- Linux (ARM64)
- macOS (Intel)
- macOS (Apple Silicon)

## Submitting Changes

### Pre-submission Checklist

- [ ] Code follows style guidelines
- [ ] All tests pass
- [ ] ShellCheck passes with no errors
- [ ] Documentation updated (if needed)
- [ ] Commit messages follow convention
- [ ] Branch is up to date with main

### Create Pull Request

1. Push your changes:

```bash
git push origin feature/your-feature
```

2. Open a Pull Request on GitHub

3. Fill out the PR template:
   - Describe your changes
   - Reference related issues
   - List testing performed
   - Add screenshots (if UI changes)

4. Wait for review and address feedback

### Pull Request Review Process

- Maintainers will review within 7 days
- CI must pass (linting, tests)
- At least one approval required
- Squash commits if requested

## Coding Standards

### Shell Script Style

Follow Google Shell Style Guide with these specifics:

#### Indentation

- Use 2 spaces (no tabs)
- Indent case statements:

```bash
case "$var" in
  option1)
    command
    ;;
  option2)
    command
    ;;
esac
```

#### Variables

- Use lowercase with underscores for local variables:

```bash
local my_variable="value"
```

- Use uppercase for constants:

```bash
readonly GITHUB_REPO="metatypedev/ghjk"
```

- Always quote variables:

```bash
echo "$my_variable"  # Good
echo $my_variable    # Bad
```

#### Functions

- Use descriptive names in lowercase with underscores:

```bash
get_platform() {
  # Implementation
}
```

- Add comments for complex functions:

```bash
# Download file with retry logic
# Arguments:
#   $1 - URL to download
#   $2 - Output path
# Returns:
#   0 on success, 1 on failure
download_file() {
  # Implementation
}
```

#### Error Handling

- Use `set -euo pipefail` at script start
- Check command results:

```bash
if ! curl -fsSL "$url" -o "$output"; then
  error "Download failed"
  return 1
fi
```

- Provide helpful error messages:

```bash
error "Failed to download ghjk ${version}"
error "Check your internet connection and try again"
```

#### Logging

Use provided logging functions:

```bash
log "Downloading version $version"
success "Installation complete"
warn "Checksum not available"
error "Installation failed"
```

### ShellCheck Compliance

- Fix all ShellCheck warnings
- Use directives when necessary:

```bash
# shellcheck disable=SC2034
unused_variable="value"
```

- Document why checks are disabled

### Testing Standards

- Write tests for new features
- Maintain or improve code coverage
- Use descriptive test names:

```bash
@test "download creates metadata file" {
  # Test implementation
}
```

## Documentation

### Update Documentation

When making changes, update relevant docs:

- **README.md** - User-facing features
- **CLAUDE.md** - Development guidelines
- **CONTRIBUTING.md** - Process changes
- **docs/** - Detailed guides

### Documentation Style

- Use clear, concise language
- Include code examples
- Add troubleshooting sections
- Keep formatting consistent

## Release Process

Maintainers follow this process for releases:

1. Update version references
2. Update CHANGELOG.md
3. Create git tag: `git tag v1.0.0`
4. Push tag: `git push origin v1.0.0`
5. GitHub Actions creates release automatically
6. Announce in discussions

## Getting Help

- **Questions**: Open a discussion
- **Bugs**: Open an issue with reproduction steps
- **Features**: Open an issue with use case
- **Security**: Email maintainers privately

## Recognition

Contributors are recognized in:
- GitHub contributors list
- Release notes
- Project documentation

Thank you for contributing! 🎉
