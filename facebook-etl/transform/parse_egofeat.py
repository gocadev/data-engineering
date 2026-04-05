# Parse .egofeat files, which contain 224 features for the ego user in a single line.
# Return a tuple: (ego_id, feat1, feat2, ... feat224)
def parse_egofeat(file_path, ego_id):
    rows = []
    with open(file_path, "r") as f:
        line = f.readline().strip().split()

        for feature_key, value in enumerate(line):
            if value == "1":
                rows.append((ego_id, str(feature_key), "1"))

    return rows