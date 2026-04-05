## parse .edges files, line format: 'src dst' 
# return list of tuples (ego_id, src, dst)
def parse_edges(raw_lines, ego_id):
    edges = []

    for line in raw_lines:
        if not line.strip():
            continue  # skips empty lines

        parts = line.split()

        # every line should have exactly 2 parts (src and dst)
        if len(parts) != 2:
            continue  # skip lines that don't match the expected format

        try:
            src = int(parts[0])
            dst = int(parts[1])
        except ValueError:
            # skip lines where src or dst are not integers
            continue

        edges.append((ego_id, src, dst))

    return edges