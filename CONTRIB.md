# Contributing to xsos

Some suggestions for contributors.

The upstream sos guidelines provide good git practice with branches and commits:

https://github.com/sosreport/sos/wiki/Contribution-Guidelines

## Style

Try to keep roughly within the established bash/awk style.

## Testing

### Lint / static checks

The CI runs the following checks locally; please run them before opening a PR:

```bash
bash -n xsos
bash -n xsos-bash-completion.bash

# ShellCheck is optional locally but strongly recommended.
# CI runs ShellCheck in "errors only" mode to catch real breakage while avoiding
# a huge amount of warning-only churn.
shellcheck -S error -x xsos xsos-bash-completion.bash
```

### Targets - what xsos is run against

Where possible, test against sosreports from the in-support versions of RHEL and Ubuntu LTS.

sosreport 3.9 onwards needs to be run with `sosreport --allow-system-changes`

Fedora would also be nice.

### Clients - what xsos is actually run on

Test execution of the script on latest RHEL and Ubuntu LTS.

Fedora would also be nice.

