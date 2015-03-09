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

