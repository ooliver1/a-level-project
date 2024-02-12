import re
import sys

SCALE_FACTOR = int(sys.argv[2])

with open(sys.argv[1]) as f:
    data = f.read()
    data = re.sub(
        r"((?:texture|atlas)\s*=\s*ExtResource\(\s*1\s*\)\n\w+\s*=\s*Rect2\(\s*)(\d+)(\,\s*)(\d+)(\,\s*)(\d+)(\,\s*)(\d+)(\s*\))",
        lambda x: x.expand(
            fr"\g<1>{int(x.group(2)) * SCALE_FACTOR}\g<3>{int(x.group(4)) * SCALE_FACTOR}\g<5>{int(x.group(6)) * SCALE_FACTOR}\g<7>{int(x.group(8)) * SCALE_FACTOR}\g<9>"
        ),
        data,
    )
    data = re.sub(
        r"(margin_\w+\s*=\s*)([0-9.]+)",
        lambda x: x.expand(fr"\g<1>{float(x.group(2)) * SCALE_FACTOR}"),
        data,
    )

    with open(sys.argv[1].removesuffix(".tres") + "_new.tres", "w") as f:
        f.write(data)
