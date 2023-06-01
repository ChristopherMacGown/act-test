import json
import re
import sys

BLACK_OUTPUT_RE = re.compile(
    r"(?P<count>\d+)"  # The number of changes black's reporting
    r"\s+file[s]?(\s+would( be)?)?\s+"  # Filler
    r"?(?P<action>.*$)"  # The action in question.
)

PRETTIER_OUTPUT_RE = re.compile(
    r"^\[warn\] Code style issues found in (?P<count>\d+) files.*$"
)


def build_report(*, action, count):
    if action == "left unchanged":
        return None
    action = "remaining" if "fail" in action else "fixable"
    return {action: int(count)}


def parse_black(black):
    for line in black.rstrip(".").split(", "):
        match = BLACK_OUTPUT_RE.match(line)
        if not match:
            raise Exception(f"Unexpected input from Black!: {line}")
        print(json.dumps(build_report(**match.groupdict())))


def parse_prettier(prettier):
    match = PRETTIER_OUTPUT_RE.match(prettier)
    if not match:
        raise Exception(f"Unexpected input from Prettier!: {prettier}")
    print(json.dumps(build_report(action="fix", **match.groupdict())))


PARSERS = dict(
    black=parse_black,
    prettier=parse_prettier,
)

if __name__ == "__main__":

    def usage():
        print(f"Usage: {sys.argv[0]} [black|prettier]")
        sys.exit(-1)

    if len(sys.argv) != 2:
        usage()

    parser = PARSERS.get(sys.argv[1], None)
    if not parser:
        usage()

    parser(sys.stdin.read().strip())
