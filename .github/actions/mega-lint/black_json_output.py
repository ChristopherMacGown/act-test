import json
import re
import sys

BLACK_OUTPUT_RE = re.compile(
    r"(?P<count>\d+)"  # The number of changes black's reporting
    r"\s+file[s]?(\s+would( be)?)?\s+"  # Filler
    r"?(?P<action>.*$)"
)  # The action in question.


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


if __name__ == "__main__":
    parse_black(sys.stdin.read().strip())
