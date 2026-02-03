# This file is meant to be `source`d
# To run Verilator that was built in-place within this git repo.

# See http://www.ostricher.com/2014/10/the-right-way-to-get-the-directory-of-a-bash-script/
THIS_VERILATOR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )"
echo "Configuring your shell to use verilator from ${THIS_VERILATOR_DIR}."
export VERILATOR_ROOT=${THIS_VERILATOR_DIR}

export PATH=${VERILATOR_ROOT}/bin:${PATH}
