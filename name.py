import os

def list_files_in_folder(folder_path):
    file_names = os.listdir(folder_path)
    for file_name in file_names:
        print(file_name)

folder_path = "e:\Prolog_Projects"  # Replace this with the actual folder path
list_files_in_folder(folder_path)
