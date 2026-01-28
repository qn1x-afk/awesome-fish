import os
import shutil
from .install_fish import fish_install

def install(*args, **kwargs):
    current_directory = os.getcwd()
    awesome_fish_directory = os.path.join(current_directory, "awesome-fish")
    fish_config_location = os.path.expanduser("~/.config/fish")
    print(f"Fish config location: {fish_config_location}")

    # Change to the current working directory
    os.chdir(fish_config_location)
    
    # List all files and directories in the current directory
    items = os.listdir(fish_config_location)
    
    if os.path.exists(f"{fish_config_location}/functions"):
        print("The functions directory exists")
        
        # Copy contents of awesome-fish directory to functions directory
        if os.path.exists(awesome_fish_directory):
            for item in os.listdir(awesome_fish_directory):
                source_path = os.path.join(awesome_fish_directory, item)
                dest_path = os.path.join(f"{fish_config_location}/functions", item)
                
                if os.path.isdir(source_path):
                    shutil.copytree(source_path, dest_path, dirs_exist_ok=True)
                else:
                    shutil.copy2(source_path, dest_path)
            
            print("Awesome Fish contents have been copied to the functions directory")
        else:
            print("Awesome Fish directory not found")

    else:
        print("Please ensure that the Friendly Interactive Shell is installed.")
        result = input("Do you want to install it? (y/n): ")
        if result == "y":
            fish_install(*args, **kwargs)
        else:
            print("Exiting...")
            exit()


