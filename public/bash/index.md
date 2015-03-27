## stdout and stderr

#### Redirect both stdout and stderr to stdout

```bash
echo "Echo this to stdout" 2>&1

# Ignore output of my command by redirecting both stdout and stderr to /dev/null
mycommand > /dev/null 2>&1
```

#### Redirect both a log file
```bash
# java system out and err to a log file
${JAVA_HOME}/bin/java -cp ${CLASSPATH} ${JVMPROPS} ${MAIN_CLASS} ${ARGS} > ${LOGFILE} 2>&1

# as background process using nohup
nohup ${JAVA_HOME}/bin/java -cp ${CLASSPATH} ${JVMPROPS} ${MAIN_CLASS} ${ARGS} > ${LOGFILE} 2>&1&
```

#### Redirecto both to stderr
Usually when you want to log some output as error (e.g. to error.log file or some end point)
```bash
echo "Error occurred!" 1>&2
OR
echo "Error occurred!" >&2
```

## Get bash script directory
```bash
BASE_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
```

## Exit script on error
set -e (or set -o errexit)

```bash
#!/bin/bash
set -e

```
"set -e" gotcha: http://mywiki.wooledge.org/BashFAQ/105

## Some bash options

```
$ help set
...
-e  Exit immediately if a command exits with a non-zero status.
-u  Treat unset variables as an error when substituting.
-v  Print shell input lines as they are read.
-x  Print commands and their arguments as they are executed.
```

```
set -e (set -o errexit)
set -u (set -o nounset)
set -v (set -o verbose)
set -x (set -o xtrace)
```

### Set options in scripts
```
#!/bin/bash
set -eu

# Turn off "errexit"
set +e

# allow exit with non-zero status in here

set -e
# Turn "errexit" option on again

```

### Run script with specific option

Use -x and -v option for debugging

```bash
$ bash -x /path/to/script
$ bash -v /path/to/script
```

More debugging: http://gfxmonk.net/2012/06/17/my-new-bash-script-prelude.html

## Check command exists
```bash
$ command -v mycommand >/dev/null 2>&1 || { echo "I need mycommand but it's not installed. Existing." >&2; exit 1; }
```

Based on: https://get.docker.com/
```bash
command_exists() {
    command -v "$@" > /dev/null 2>&1
}

if command_exists docker || command_exists lxc-docker; then
    echo >&2 'Warning: "docker" or "lxc-docker" command appears to already exist.'
    echo >&2 'Please ensure that you do not already have docker installed.'
    echo >&2 'You may press Ctrl+C now to abort this process and rectify this situation.'
    ( set -x; sleep 20 )
fi
```

### Download file

```
curl=''
if command_exists curl; then
    curl='curl -sSL'
elif command_exists wget; then
    curl='wget -qO-'
elif command_exists busybox && busybox --list-modules | grep -q wget; then
    curl='busybox wget -qO-'
fi
```

### Check user name
```bash
$ id -un
```

Based on: https://get.docker.com/
```bash
set -e

user=$(id -un 2>/dev/null || true)

sh_c='sh -c'
if [ "$user" != 'root' ]; then
    if command_exists sudo; then
        sh_c='sudo -E sh -c'
    elif command_exists su; then
        sh_c='su -c'
    else
        echo >&2 'Error: this installer needs the ability to run commands as root.'
        echo >&2 'We are unable to find either "sudo" or "su" available to make this happen.'
        exit 1
    fi
fi

if command_exists docker && [ -e /var/run/docker.sock ]; then
    (
        set -x
        $sh_c 'docker version'
    ) || true
fi
```

### Check if url is accessible

```bash
if curl -sSf https://get.docker.com/ > /dev/null; then
    wget -qO- https://get.docker.com/ | sh
    exit $?
fi
```
