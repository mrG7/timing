#!/usr/bin/env python
import os
import subprocess
import sys
import time

PATH = os.path.dirname(__file__)


def run(cmd):
    cmdline = PATH + "/%s/%s" % (cmd, cmd)
    out = subprocess.check_output(cmdline)
    out = out.decode("utf-8")
    print("\n".join(out.splitlines()[10:]))


def main(cmd):
    target = time.time() + 5

    last_time = None
    while time.time() < target:
        run(cmd)
        time.sleep(0.1)
        time_left = int(target - time.time())
        if time_left != last_time:
            last_time = time_left
            #print(time_left)#


if __name__ == '__main__':
    sys.exit(main(*sys.argv[1:]))
