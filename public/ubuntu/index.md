## crontab as root

### Example crontab

```bash
$ cat contab
# m h  dom mon dow   command
0 1 * * * ${HOME}/cronjobs.sh 2>&1 | tee -a ${HOME}/cronjobs.log
```

#### Install as root's crontab

```bash
$ sudo crontab /path/to/crontab
```
