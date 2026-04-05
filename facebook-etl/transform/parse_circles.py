## parse .circles files, line format: 'circle_name: member1 member2 ...'
# return two lists:
# circles_list -> [(ego_id, circle_name)]
# members_list -> [(ego_id, circle_name, member_id)]
def parse_circles(raw_lines, ego_id):
    circles_list = []
    members_list = []

    for line in raw_lines:
        if not line.strip():
            continue  # skips empty lines

        # format: name: id1 id2 id3
        if ":" not in line:
            continue

        circle_name, members_str = line.split(":", 1)

        circle_name = circle_name.strip()
        members_str = members_str.strip()

        # add circle to list
        circles_list.append((ego_id, circle_name))

        # parse members
        if members_str:
            member_ids = members_str.split()

            for m in member_ids:
                try:
                    member_id = int(m)
                except ValueError:
                    continue

                members_list.append((ego_id, circle_name, member_id))

    return circles_list, members_list