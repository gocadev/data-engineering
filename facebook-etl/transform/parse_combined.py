## Parse combined file facebook_combined.txt
# each line has format: 'src dst'
# return list of tuples (src, dst)
def parse_combined(raw_lines):
    edges = []

    for line in raw_lines:
        if not line.strip():
            continue  # skips empty lines

        parts = line.split()

        if len(parts) != 2:
            continue  # skips lines that don't match the expected format

        try:
            src = int(parts[0])
            dst = int(parts[1])
        except ValueError:
            continue  # skips lines where src or dst are not integers

        edges.append((src, dst))

    return edges