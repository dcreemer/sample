# Application code
from lib.calculate import add_strings


def appfun(n: str) -> str:
    return "Application Function " + add_strings(n, "1")
