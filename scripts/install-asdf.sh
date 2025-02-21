#!/bin/bash
set -eu -o pipefail

if [ $(uname -s) != "Linux" ]; then
  echo "error: Your platform is not supported."
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

echo "# Get version"
ASDF_LATEST_VERSION=$(curl -sSL https://api.github.com/repos/asdf-vm/asdf/releases/latest | jq -r .tag_name)
echo ""

echo "# Clone repository"
git clone --branch $ASDF_LATEST_VERSION --depth 1 https://github.com/asdf-vm/asdf.git ~/.asdf
echo ""

echo "# Set up shell"
cat << 'EOF' >> ~/.bashrc

# BEGIN asdf
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"
# END asdf
EOF
echo ""

echo "Complete!"
