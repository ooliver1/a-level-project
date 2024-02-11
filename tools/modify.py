import re
import sys

SCALE_FACTOR = int(sys.argv[2])

with open(sys.argv[1]) as f:
    data = f.read()
    data = re.sub(r"Rect2\((\d+)\,\s+(\d+)\,\s+(\d+)\,\s+(\d+)\)", lambda x: (print(x, f"Rect2({int(x.group(1))*SCALE_FACTOR}, {int(x.group(2))*SCALE_FACTOR}, {int(x.group(3))*SCALE_FACTOR}, {int(x.group(4))*SCALE_FACTOR})"), f"Rect2({int(x.group(1))*SCALE_FACTOR}, {int(x.group(2))*SCALE_FACTOR}, {int(x.group(3))*SCALE_FACTOR}, {int(x.group(4))*SCALE_FACTOR})")[1], data)

    with open(sys.argv[1].removesuffix(".tres") + "_new.tres", "w") as f:
        f.write(data)
