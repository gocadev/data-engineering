## Parse .feat files, line format: 'user_id feat1 feat2 feat3 ... feat224'
# return list of tuples (ego_id, user_id, feat1, feat2, ...
def parse_feat(raw_lines, ego_id):
    rows = []

    for line in raw_lines:
        parts = line.strip().split()
        user_id = int(parts[0])
        features = parts[1:]

        for feature_key, value in enumerate(features):
            if value == "1":
                rows.append((ego_id, user_id, str(feature_key), "1"))

    return rows