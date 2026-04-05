import os

# EXTRACT
from extract.list_files import list_files
from extract.read_files import read_raw_file

# UTILS
from utils.helpers import (
    get_filename,
    extract_ego_id,
    detect_file_type
)

# TRANSFORM
from transform.parse_edges import parse_edges
from transform.parse_feat import parse_feat
from transform.parse_egofeat import parse_egofeat
from transform.parse_circles import parse_circles
from transform.parse_combined import parse_combined
from transform.parse_feature_names import parse_feature_names

# LOAD
from load.load_to_db import (
    load_edges,
    load_features,
    load_egofeatures,
    load_circles,
    load_circle_members,
    load_combined_edges,
    load_feature_names
)


DATA_FOLDER = "data/raw"


def main():
    print("Starting ETL pipeline...")

    files = list_files(DATA_FOLDER)

    for path in files:
        filename = get_filename(path)
        file_type = detect_file_type(filename)
        ego_id = extract_ego_id(filename)

        print(f"Processing file: {filename}  | type: {file_type}  | ego_id: {ego_id}")

        raw_lines = read_raw_file(path)

        # ---------------------------------------------------------
        # 1) COMBINED GRAPH (facebook_combined.txt)
        # ---------------------------------------------------------
        if file_type == "combined":
            parsed = parse_combined(raw_lines)
            load_combined_edges(parsed)
            print(f"Loaded {len(parsed)} global edges.")
            continue

        # ---------------------------------------------------------
        # 2) EDGES
        # ---------------------------------------------------------
        if file_type == "edges":
            parsed = parse_edges(raw_lines, ego_id)
            load_edges(parsed)
            print(f"Loaded {len(parsed)} edges for ego_id {ego_id}.")
            continue

        # ---------------------------------------------------------
        # 3) FEAT
        # ---------------------------------------------------------
        if file_type == "feat":
            parsed = parse_feat(raw_lines, ego_id)
            load_features(parsed)
            print(f"Loaded {len(parsed)} feature rows for ego_id {ego_id}.")
            continue

        # ---------------------------------------------------------
        # 4) EGOFEAT
        # ---------------------------------------------------------
        if file_type == "egofeat":
            parsed = parse_egofeat(path, ego_id)
            load_egofeatures(parsed)
            print(f"Loaded {len(parsed)} ego features for ego_id {ego_id}.")
            continue

        # ---------------------------------------------------------
        # 5) CIRCLES
        # ---------------------------------------------------------
        if file_type == "circles":
            circles, members = parse_circles(raw_lines, ego_id)
            load_circles(circles)
            load_circle_members(members)
            print(f"Loaded {len(circles)} circles and {len(members)} members for ego_id {ego_id}.")
            continue

        # ---------------------------------------------------------
        # 6) FEATURE NAMES
        # ---------------------------------------------------------
        if file_type == "feature_names":
            parsed = parse_feature_names(raw_lines)
            load_feature_names(parsed)
            print(f"Loaded {len(parsed)} feature names.")
            continue

        print(f"Skipping file: {filename} (unknown type)")


if __name__ == "__main__":
    main()