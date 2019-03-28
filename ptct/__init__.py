# -*- coding: utf-8 -*-

"""Top-level package for Python Temperature Conversion Test."""
from __future__ import absolute_import

__author__ = """Alex Moore"""
__email__ = 'alexander.g.moore1@gmail.com'
__version__ = '0.1.1'

__all__ = ['check', 'cli', 'convert', 'logger', 'main', 'name_map',
           'to_celsius', 'to_fahrenheit', 'to_kelvin', 'to_rankine']

from ptct.main import check, convert, name_map, \
    to_celsius, to_fahrenheit, to_kelvin, to_rankine
