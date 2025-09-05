#!/bin/bash
set -e

GRAPHVIZ_VERSION=${VERSION:-"latest"}

# Clean up
cleanup() {
    case "${1:-}" in
        --exit) exit $2 ;;
    esac
}
trap cleanup EXIT
trap 'cleanup --exit 130' INT
trap 'cleanup --exit 143' TERM

echo "Starting Graphviz installation..."
echo "Version: ${GRAPHVIZ_VERSION}"

# Detect OS and package manager
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS_ID=$ID
    OS_VERSION=$VERSION_ID
fi

# Update package manager
if command -v apt-get > /dev/null 2>&1; then
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    PACKAGE_MANAGER="apt"
elif command -v yum > /dev/null 2>&1; then
    yum update -y
    PACKAGE_MANAGER="yum"
elif command -v apk > /dev/null 2>&1; then
    apk update
    PACKAGE_MANAGER="apk"
else
    echo "Unsupported package manager"
    exit 1
fi

install_from_package_manager() {
    local version_to_install=$1
    
    echo "Installing Graphviz from package manager..."
    
    case $PACKAGE_MANAGER in
        "apt")
            if [ "$version_to_install" = "latest" ]; then
                apt-get install -y graphviz
            else
                # Try to install specific version
                apt-get install -y "graphviz=${version_to_install}*" || apt-get install -y graphviz
            fi
            ;;
        "yum")
            if [ "$version_to_install" = "latest" ]; then
                yum install -y graphviz
            else
                yum install -y "graphviz-${version_to_install}" || yum install -y graphviz
            fi
            ;;
        "apk")
            if [ "$version_to_install" = "latest" ]; then
                apk add --no-cache graphviz
            else
                apk add --no-cache "graphviz=${version_to_install}" || apk add --no-cache graphviz
            fi
            ;;
    esac
    
    echo "Graphviz installed from package manager successfully"
}

# Install from package manager
install_from_package_manager "$GRAPHVIZ_VERSION"

# Verify installation
if command -v dot > /dev/null 2>&1; then
    echo "Graphviz installation verified successfully"
    dot -V
else
    echo "Graphviz installation failed"
    exit 1
fi

echo "Graphviz installation completed!"