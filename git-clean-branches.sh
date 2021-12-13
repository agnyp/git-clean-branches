#!/bin/bash

set -ef

export help=$(cat <<HELP
This script goes through the local git-branches, displays their state (local and remote)
and offers to delete it. Shows also commit-info [i] if you need more information for your decision.

Commands
n,N   - No [default]
y,d   - Yes
i     - info: show branches' git log with stats
?,h,H - display this help
Any other character is treated like default No.
HELP
)

prompt() {
  while true; do
    echo $branch
    read -p "$(tput setaf 6)Delete local branch '$ref'? (N/y/i/q/?)$(tput sgr0)" command
    case $command in
      i     ) git log --decorate -1 --stat $ref;echo;;
      [?hH] ) echo $(tput setaf 2)"$help"$(tput sgr 0);echo;;
      *     ) break;;
    esac
  done
}

main() {
  local command
  local branch

  read -p "Fetch from origin? (y/N)" fetch
  if [ "$fetch" = "y" ]; then
    echo "Fetching from origin and pruning ..."
    git fetch --prune origin
    echo
  fi

  while read -u 3 -r branch; do
    local ref=$(echo $branch|cut -d " " -f1)
    if [[ "$ref" == "master" ]]; then
      continue
    fi
    if [[ "$ref" == "*" ]]; then
      current=$(echo $branch|cut -d " " -f2)
      if [[ "$current" == "master" ]]; then
        continue
      fi
      echo "You're currently on branch: $(tput setaf 2)$current$(tput sgr 0)"
      echo $(tput setaf 1)"switch to another branch if you want to delete this one. Skipping..."$(tput sgr0)
      echo
      continue
    fi

    prompt "$branch"
    case $command in
      q    ) echo "Exiting program."; exit;;
      [Nn] ) continue;;
      [yd] )
        echo "Deleting branch: $ref";
        git branch -D "$ref";
        echo
        ;;
      *    ) continue;;
    esac
  done 3< <( git branch --color=never -l -vv )
}

main
