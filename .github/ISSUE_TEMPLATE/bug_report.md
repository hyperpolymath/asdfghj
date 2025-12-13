---
name: Bug report
about: Create a report to help us improve
title: "[BUG] "
labels: bug
assignees: ''

---

## Bug Description

A clear and concise description of what the bug is.

## To Reproduce

Steps to reproduce the behavior:

1. Run command '...'
2. See error '....'
3. ...

## Expected Behavior

A clear and concise description of what you expected to happen.

## Actual Behavior

What actually happened.

## Environment

Please complete the following information:

- OS: [e.g., Ubuntu 22.04, macOS 14.0]
- Architecture: [e.g., x86_64, arm64]
- asdf version: [output of `asdf --version`]
- ghjk version: [output of `ghjk --version` if installed]
- Plugin version: [run `cd ~/.asdf/plugins/ghjk && git log -1 --oneline`]

```bash
# Run these commands and paste output
uname -a
bash --version
asdf --version
asdf current ghjk
```

## Debug Output

If applicable, run the failing command with debug enabled:

```bash
ASDF_DEBUG=1 asdf install ghjk <version> 2>&1
```

<details>
<summary>Debug output</summary>

```
Paste debug output here
```

</details>

## Additional Context

Add any other context about the problem here.

- Have you tried the troubleshooting guide? [Yes/No]
- Does this happen with multiple ghjk versions? [Yes/No/Unknown]
- Does this happen on a fresh install? [Yes/No/Unknown]

## Possible Solution

If you have any ideas about what might be causing this or how to fix it, please share.
