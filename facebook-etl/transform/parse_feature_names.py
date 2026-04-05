def parse_feature_names(raw_lines):
    rows = []
    for line in raw_lines:
        parts = line.strip().split()
        if len(parts) == 2:
            feature_key, feature_description = parts
            rows.append((feature_key, feature_description))
    return rows