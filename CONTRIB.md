# Contributing to xsos

Some suggestions for contributors.

The upstream sos guidelines provide good git practice with branches and commits:

https://github.com/sosreport/sos/wiki/Contribution-Guidelines

## Style

Try to keep roughly within the established bash/awk style.

## Testing

### Targets - what xsos is run against

Where possible, test against sosreports from the in-support versions of RHEL and Ubuntu LTS.

sosreport 3.9 onwards needs to be run with `sosreport --allow-system-changes`

Fedora would also be nice.

### Clients - what xsos is actually run on

Test execution of the script on latest RHEL and Ubuntu LTS.

Fedora would also be nice.

