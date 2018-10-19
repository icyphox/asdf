# cli-alarm

a simple commandline interface to quickly set alarms, possibly using a cronjob.

### examples

```
$ alarm -s 1730
alarm set for 9 hrs and 17 min from now

$ alarm -s 430 --repeat sat sun

$ alarm -l
1. 1730 - 9 hrs and 17 min from now
2. 430  - saturday, sunday

$ alarm -d 1
REMOVED: 1730 - everyday
```
### existing stuff
`at(1)` is something like this, i guess
