## read files and return list of lines
def read_raw_file(path):
    with open(path, "r", encoding="utf-8") as f:
        lines = f.read().splitlines()
    return lines