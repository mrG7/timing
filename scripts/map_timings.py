import sys
from collections import namedtuple
from pprint import pformat

import yaml
from jinja2 import Environment, FileSystemLoader, select_autoescape

Output = namedtuple("Output", ["cpu", "human"])

def unit_sort(x):
    raw = 1 - x[0]
    if raw < 0:
        return abs(raw) * 0.001
    return raw

def render(**kw):
    env = Environment(loader=FileSystemLoader('./'), autoescape=select_autoescape(['html']))
    template = env.get_template('template.html')
    return template.render(**kw)


def main():
    units = yaml.load(open("../data/units.yaml"))
    actions = yaml.load(open("../data/actions.yaml"))
    timings = yaml.load(open("../data/timings.yaml"))

    def to_secs(value, unit):
        return value * units[unit]

    for action in actions:
        action['actual_min'] = to_secs(action['min'], action['units'])
        action['actual_max'] = to_secs(action['max'], action['units'])

    def to_unit_val(value):
        scaled = [(value / num_secs, name) for name, num_secs in units.items() if name != "cycle"]
        return sorted(scaled, key=unit_sort)[0]

    def best_action(min_val, max_val):
        for action in actions:
            if action['actual_min'] < max_val and action['actual_max'] > min_val:
                return action

    blink_scale = to_secs(0.25, 'cycle') / 0.1
    outputs = []
    for i, timing in enumerate(timings, 2):
        actual_min = to_secs(timing['min'], timing['units'])
        actual_max = to_secs(timing['max'], timing['units'])
        
        blink_min = actual_min / blink_scale
        blink_max = actual_max / blink_scale

        unit_min = to_unit_val(actual_min)
        unit_max = to_unit_val(actual_max)

        timing['unit_min'] = "%.1f %s" % unit_min
        timing['unit_max'] = "%.1f %s" % unit_max

        best = best_action(blink_min, blink_max)
        if best is None:
            sys.stderr.write(f'{pformat(timing)} - {to_unit_val(blink_min)}\n')
        else:
            outputs.append(Output(timing, best))
    print(render(timings=outputs, enumerate=enumerate))


if __name__ == '__main__':
    sys.exit(main())
