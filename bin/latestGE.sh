#!/bin/zsh
set -euo pipefail


#Change directory to Proton Installs
cd ~/Proton

# download  tarball
curl -sLOJ "$(curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest | grep browser_download_url | cut -d\" -f4 | grep .tar.gz)"

# download checksum
curl -sLOJ "$(curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest | grep browser_download_url | cut -d\" -f4 | grep .sha512sum)"

# check tarball with checksum
sha512sum -c ./*.sha512sum
# if result is ok, continue

# extract proton tarball to steam directory
tar -xvf GE-Proton*.tar.gz -C ~/.steam/root/compatibilitytools.d/

echo "All done :)"
