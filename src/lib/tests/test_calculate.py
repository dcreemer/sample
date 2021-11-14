# unittest for the calculate module

from ..calculate import add_strings


def test_add_strings() -> None:
    assert add_strings("1", "2") == "3"
    assert add_strings("0", "0") == "0"
