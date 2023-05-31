import unittest


def hello(s):
    return f"Hello, {s}!"


class TestHelloWorld(unittest.TestCase):
    def test_hello_world(self):
        self.assertEqual(hello("world"), "Hello, world!")
