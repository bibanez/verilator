#!/usr/bin/env bash

### INSTALL PREREQUISITES:
#
#  # Verilator required dependencies
#  sudo apt-get install perl python3 autoconf make g++ libfl2 libfl-dev zlibc zlib1g zlib1g-dev flex bison
#
#  # Verilator optional dependencies that improve performance
#  sudo apt-get install ccache libgoogle-perftools-dev numactl
#
#  # Helpful Verilator development tools
#  sudo apt-get install gdb graphviz
#  # Note: the Verilator documentation suggests the following tools as well,
#  #       but we don't need to install them:
#  #        - cmake: You can't built Verilator itself with CMake, only with autoconf + make.
#  #               It's possible to build Verilated code with CMake, but we don't need this.
#  #        - clang clang-format: Use /data/sanchez/tools/llvm-*, or use newer
#  #               version (e.g., clang-format-10) installed at system level
#  #        - lcov: Eh, we aren't running code coverage testing yet.
#
#  # Tools used for Verilator documentation
#  python3 -m pip install --user sphinx sphinx_rtd_theme breathe
#  sudo apt-get install perl-doc
#  cpan install Pod::Perldoc  # Note, no need for sudo, local::lib installation is fine
#
#  # Needed for Verilator tests
#  cpan install Parallel::Forker  # Note, no need for sudo, local::lib installation is fine

echo "[setup] Running make distclean..."
make distclean

set -e

echo "[setup] Running autoconf..."
echo "[setup] If autoconf takes more than a couple of seconds, it's probably stuck on flock()..."
autoconf
echo "[setup] autoconf has generated configure script."

# Build and run Verilator in-place within this git repo.
# See http://www.ostricher.com/2014/10/the-right-way-to-get-the-directory-of-a-bash-script/
THIS_VERILATOR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )"
echo "[setup] Configuring build for ${THIS_VERILATOR_DIR}."
export VERILATOR_ROOT=${THIS_VERILATOR_DIR}

# Turn on compiler warnings when building Verilor itself as well as
# when building Verilated code.
export VERILATOR_AUTHOR_SITE=1

./configure --enable-ccwarn --enable-longtests

echo "[setup] Configure completed."

echo "[setup] After building verilator using make, source ./env.sh to use verilator"
