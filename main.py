import os

def main():
    # Get the current working directory
    current_directory = os.getcwd()
    
    # List all files and directories in the current directory
    items = os.listdir(current_directory)
    
    # Print the items
    print("Items in the current directory:")
    for item in items:
        print(item)


if __name__ == "__main__":
    main()
