import os

## get filename without path
def get_filename(path):
    return os.path.basename(path)

## get extension of filename
def get_extension(filename):
    return os.path.splitext(filename)[1]

## get ego_id from filename sample: '107.edges' → 107, return None if not a number (e.g. facebook_combined.txt)
def extract_ego_id(filename):
    name = filename.split(".")[0]
    if name.isdigit():
        return int(name)
    return None

## detect file type based on extension and filename
def detect_file_type(filename):
    ext = get_extension(filename)

    if filename == "facebook_combined.txt":
        return "combined"

    if ext == ".edges":
        return "edges"

    if ext == ".feat":
        return "feat"

    if ext == ".egofeat":
        return "egofeat"

    if ext == ".circles":
        return "circles"

    return "unknown"