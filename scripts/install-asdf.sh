#!/bin/bash
set -eu -o pipefail

if [ $(uname -s) != "Linux" ]; then
  echo "error: Your platform is not supported."
  exit 1
fi

OS_ARCH=$(uname -m)
if [ "$OS_ARCH" == "aarch64"]; then
  OS_ARCH="arm64"
fi

if [ "$OS_ARCH" != "amd64" ] && [ "$OS_ARCH" != "arm64" ]; then
  echo "error: Your architecture is not supported."
  exit 1
fi

if command -v asdf > /dev/null 2>&1; then
  echo "exit: Already installed asdf"
  exit 0
fi

if !(command -v jq > /dev/null 2>&1); then
  echo "error: Please install the jq command"
  exit 1
fi

echo "# Install asdf CLI"
ASDF_LATEST_VERSION=$(curl -sSL https://api.github.com/repos/asdf-vm/asdf/releases/latest | jq -r .tag_name)
curl -sL "https://github.com/asdf-vm/asdf/releases/download/${ASDF_LATEST_VERSION}/asdf-${ASDF_LATEST_VERSION}-linux-${OS_ARCH}.tar.gz" | sudo tar -zxv -C /usr/local/bin
echo ""

echo "# Set up shell"
cat << 'EOF' >> ~/.bash_profile

# BEGIN asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
# END asdf
EOF
cat << 'EOF' >> ~/.bashrc

# BEGIN asdf
. <(asdf completion bash)
# END asdf
EOF
echo ""

echo "Complete!"
