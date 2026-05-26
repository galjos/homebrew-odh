# Homebrew Tap For `odh`

This is the Homebrew tap for
[`odh`](https://github.com/galjos/odh-cli), an agent-friendly CLI for public
Open Data Hub APIs.

## Install

```bash
brew tap galjos/odh
brew install odh
```

Or install without a persistent tap:

```bash
brew install galjos/odh/odh
```

Verify:

```bash
odh version
odh doctor --network=false
```

## Update

```bash
brew update
brew upgrade odh
```

