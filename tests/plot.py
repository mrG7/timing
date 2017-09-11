#!/usr/bin/env python
import sys

import matplotlib.pyplot as plt


def main():
    next(sys.stdin)
    values = []
    for line in sys.stdin:
        if not line.strip():
            continue
        pid, cycles, overhead, divisor = line.strip().split(",")
        values.append((float(cycles) - float(overhead)) / float(divisor))
    values.sort()
    print(len(values), min(values))
    plt.hist(values, bins=64)
    plt.show()


if __name__ == '__main__':
    sys.exit(main())
