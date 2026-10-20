#!/bin/bash
set -euo pipefail

pushd ./radeon-profile/

# Full clean: removes generated Makefile, object files, moc output, and target binary
[[ -f Makefile ]] && make distclean

qmake6 radeon-profile.pro
make -j$(nproc)

popd
