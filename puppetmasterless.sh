#!/bin/bash
#
# masterless puppet script
#
SITEPP=$( puppet --configprint manifest )

while getopts ":nb:" opt; do
  case $opt in
    b)
      BRANCH=${OPTARG}
      ;;
    n)
      NOOP='--noop'
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

BRANCH=${BRANCH:=master}

function on_exit() {
  rm -f $(puppet --configprint puppetdlockfile)
}

trap on_exit SIGTERM

[[ $( which puppet &> /dev/null ) ]] && echo "Missing puppet" && exit 1
[[ $( which git &> /dev/null ) ]] && echo "Missing git" && exit 1
[[ -e $(puppet --configprint puppetdlockfile ) ]] && echo "puppet disabled" && NOOP="--noop"

# update super-project and submodules
cd $( puppet --configprint confdir ) && (
  git pull origin $BRANCH
  git submodule update --recursive --branch $BRANCH
)

# run puppet
puppet apply $NOOP $SITEPP
