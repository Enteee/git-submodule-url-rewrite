# git-submodule-url-rewrite
_Easy rewrite of git submodule urls_


## Features

 - [x] Rewrite submodule urls using Extended Regular Expressions (`sed -r`)
 - [x] Recursive rewrite (`-r`) for big submodule hierarchies

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

### Example

Clone [Enteee/example-dependency]
```sh
$ git clone https://github.com/Enteee/example-dependency.git
Cloning into 'example-dependency'...
remote: Enumerating objects: 39, done.
remote: Counting objects: 100% (39/39), done.
remote: Compressing objects: 100% (30/30), done.
remote: Total 39 (delta 5), reused 39 (delta 5), pack-reused 0
Unpacking objects: 100% (39/39), done.
```

The `.gitmodules` file points to [githubtraining/example-submodule.git]
```sh
$ cat example-dependency/.gitmodules
[submodule "js"]
  path = js
  url = https://github.com/githubtraining/example-submodule.git
```

Rewrite that to point to the repository [Enteee/example-submodule.git]:
```sh
$ git -C example-dependency/ submodule-url-rewrite 's|githubtraining|Enteee|'
rewrite url for submodule 'js' in '/tmp/example-dependency' from 'https://github.com/githubtraining/example-submodule.git' to 'https://github.com/Enteee/example-submodule.git'
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


[Enteee/example-dependency]:https://github.com/Enteee/example-dependency.git
[githubtraining/example-submodule.git]:https://github.com/githubtraining/example-submodule.git
[Enteee/example-submodule.git]:https://github.com/Enteee/example-submodule.git
