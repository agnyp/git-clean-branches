# git-clean-branches

Little script that helps you clean up the local-branch-mess, if you have one.

## Install

The easiest way is to copy or soft-link the script into you path.

If you want it to look nice, like in the example below, rename it to just `git-clean-branches` without the `.sh`.

Git has a nice feature: If your path contains an executable starting with git-*
you can use it withing your git-repository like this:

```
git clean-branches
```

Of course you can also execute it directly within the repo.

## Usage

The script does nothing without you explicitly giving the command. If you just press _Enter_ all the time, no changes will be made. And you can quit it at any time using the usual CTRL-C.

After first question for fetching from origin, you can press `?` for HELP.

The fetching contains the --prune flag which will clean up the remote references. If the remote branch is deleted (like after a merged or closed PR), it will indicate with the word `gone` behind the remote-branch-name within the brackets. This can be used as an indicator your local branch can be deleted.

## Contribution

If you want to contribute consider only PR which would be benefical for all users.
If you plan on something specific I suggest a fork.
