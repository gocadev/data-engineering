import os

## list files in a directory
def list_files(folder_path):
    files = []
    for filename in os.listdir(folder_path):
        full_path = os.path.join(folder_path, filename)
        if os.path.isfile(full_path):
            files.append(full_path)
    return files