# main program
import sample
from sample.appcode import appfun


def main() -> None:
    print("Hello World!", sample.__version__)
    print(appfun("1"))


if __name__ == "__main__":
    main()
