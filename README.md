# git-submodule-url-rewrite
_Easy rewrite of git submodule urls_

## Usage

```sh
$ git submodule-url-rewrite -h
usage: git submodule-url-rewrite [-h|--help] [-v|--verbose] [-q|--quiet] [-r|--recursive] [-s|--no-stage] [-u|--no-update] sed-command

Rewrites all submodule urls using the given sed-script

options:
  -h|--help       Print this help
  -v|--verbose    Make this script verbose
  -q|--quiet      Don't print anything
  -r|--recursive  Also rewrite submodules of submodules
  -s|--no-stage   Don't stage changed .gitmodule files for commit
  -u|--no-update  Don't run 'git submodule --quiet update --init' in each submodule

sed-command: A sed command used to transform urls.
```

## Installation

Installation of the command is as simple as copying the script somewhere to
your `${PATH}` and making it executable.

```sh
$ cd /usr/local/bin
$ curl \
  https://raw.githubusercontent.com/Enteee/git-submodule-url-rewrite/master/git-submodule-url-rewrite \
  --output git-submodule-url-rewrite
$ chmod a+x git-submodule-url-rewrite
```
