from dotenv import load_dotenv
load_dotenv()

def main(*args, **kwargs):
    from helpers.installer import install
    install(*args, **kwargs)

if __name__ == "__main__":
    main()
