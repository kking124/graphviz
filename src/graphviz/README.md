# Graphviz Devcontainer Feature

A production-ready devcontainer feature that installs Graphviz graph visualization software with configurable version options.

## Usage

Add this feature to your `.devcontainer/devcontainer.json`:

```json
{
  "features": {
    "ghcr.io/kking124/graphviz:latest": {
      "version": "latest"
    }
  }
}
```

## Options

| Option | Description | Type | Default | Valid Values |
|--------|-------------|------|---------|--------------|
| `version` | Version of Graphviz to install | string | `"latest"` | Any valid Graphviz version tag or `"latest"` |

## Installation Method

### Package Manager Installation
Uses the system package manager (apt, yum, apk) to install Graphviz. This is the fastest and most reliable method for all use cases.

- **Pros**: Fast installation, tested packages, minimal dependencies, reliable
- **Cons**: May not have the absolute latest version
- **Best for**: All environments - production, development, CI/CD pipelines

## Examples

### Basic Installation
```json
{
  "features": {
    "ghcr.io/kking124/graphviz:latest": {}
  }
}
```

### Install Specific Version
```json
{
  "features": {
    "ghcr.io/kking124/graphviz:latest": {
      "version": "2.50.0"
    }
  }
}
```

### Development Setup
```json
{
  "features": {
    "ghcr.io/kking124/graphviz:latest": {
      "version": "latest"
    }
  }
}
```

## Supported Platforms

- Ubuntu/Debian (apt)
- CentOS/RHEL/Fedora (yum)
- Alpine Linux (apk)

## What's Included

After installation, the following Graphviz tools will be available:

- `dot` - Filter for drawing directed graphs
- `neato` - Filter for drawing undirected graphs
- `twopi` - Filter for radial layouts
- `circo` - Filter for circular layout
- `fdp` - Filter for drawing undirected graphs
- `sfdp` - Filter for drawing large undirected graphs
- `patchwork` - Filter for tree maps

## Verification

The feature automatically verifies the installation by running `dot -V` after installation completes.

## Development

This feature is automatically built and published to GitHub Container Registry when changes are merged to the main branch.

### Repository Structure