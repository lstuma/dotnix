#!/usr/bin/env bash
# script for rebuilding nix config

notify() {
  notify-send "rebuild.sh: $1" \
    --urgency=low
}

NC='\033[0m'
RED='\033[1;91m'
GREEN='\033[1;92m'
BLUE='\033[1;94m'
YELLOW='\033[1;93m'

if [[ `git diff` ]]
then 
  echo -e "${BLUE}rebuild.sh: ${RED}found unsaved changes${NC}";
  echo -en "${BLUE}rebuild.sh: ${NC}Add and commit changes to git? [${GREEN}y${NC}/${RED}n${NC}] "
  read yn
  if [[ ! $yn =~ [Yy]+ ]]
  then
    echo -e "${BLUE}rebuild.sh: ${RED}exiting${NC}"; 
    exit -1;
  fi
  echo -e "${BLUE}rebuild.sh: ${NC}Adding changes";
  git add .;
  if [[ ! $? -eq 0 ]]
  then 
    echo -e "${BLUE}rebuild.sh: ${RED}git add failed${NC}";
    exit -1;
  fi
  CURRENT=$(nixos-rebuild list-generations | grep current)
  echo -e "${BLUE}rebuild.sh: ${NC}committing with msg ${YELLOW}${CURRENT}${NC}"
  git commit -m "${CURRENT}"
  if [[ ! $? -eq 0 ]]
  then
    echo -e "${BLUE}rebuild.sh: ${RED}git commit failed${NC}";
    exit -1;
  fi
fi

echo -e "${BLUE}rebuild.sh: ${YELLOW}rebuilding NixOS Configuration${NC}"

REBUILD_CMD="nixos-rebuild switch --flake .# --log-format internal-json -v |& nom --json"
set xtrace
sudo /usr/bin/env bash -p -c "$REBUILD_CMD"

RET=?

unset xtrace
if [[ $RET -eq 0 ]]
then
  echo -e "${BLUE}rebuild.sh: ${GREEN}build finished${NC}";
  notify "build finished";
  exit 0;
fi

echo -e "${BLUE}rebuild.sh: ${RED}build failed${NC} $RET"
notify "build failed";

