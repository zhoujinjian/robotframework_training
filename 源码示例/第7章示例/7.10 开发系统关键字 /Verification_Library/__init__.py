# coding=utf-8
from verification import Verfication
from version import VERSION

__version__ = VERSION


class Verification_Library(Verfication):
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'  # 此句作用是指该库运行的时候会作用在全局。
