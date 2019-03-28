# -*- coding: utf-8 -*-

"""Main module."""

import logging
logger = logging.getLogger(__name__)

name_map = {
    "Rankine": "R",
    "Kelvin": "K",
    "Fahrenheit": "F",
    "Celsius": "C"
}


def to_kelvin(value, unit):
    """
    :param value: magnitude in float or int format
    :param unit: units of the input one of C, F, R, or K
    :return: a float value in Kelvin converted from the input unit
    """
    kmap = {
        'C': (lambda c: c + 273.15),
        'F': (lambda f: (f + 459.67) / 1.8),
        'R': (lambda r: r / 1.8),
        'K': (lambda k: k)
    }
    return kmap[unit](float(value))


def to_celsius(value, unit):
    """
    :param value: magnitude in float or int format
    :param unit: units of the input one of C, F, R, or K
    :return: a float value in Celsius converted from the input unit
    """
    k = to_kelvin(value, unit)
    return k - 273.15


def to_fahrenheit(value, unit):
    """
    :param value: magnitude in float or int format
    :param unit: units of the input one of C, F, R, or K
    :return: a float value in Fahrenheit converted from the input unit
    """
    k = to_kelvin(value, unit)
    return k * 1.8 - 459.67


def to_rankine(value, unit):
    """
    :param value: magnitude in float or int format
    :param unit: units of the input one of C, F, R, or K
    :return: a float value in Rankine converted from the input unit
    """
    k = to_kelvin(value, unit)
    return k * 1.8


def convert(value, unit, target):
    """
    :param value: magnitude in float or int format
    :param unit: units of the input one of C, F, R, or K
    :param target: units to convert to one of C, F, R, or K
    :return: a float value in the targeted units
    """
    # Convert to short name
    if target in name_map.keys():
        target = name_map[target]
    if unit in name_map.keys():
        unit = name_map[unit]
    if unit not in ['K', 'C', 'F', 'R']:
        logger.error("{} is not a supported unit type".format(unit))
        return
    try:
        if target == 'K':
            return to_kelvin(value, unit)
        elif target == 'C':
            return to_celsius(value, unit)
        elif target == 'F':
            return to_fahrenheit(value, unit)
        elif target == 'R':
            return to_rankine(value, unit)
        else:
            logger.error("{} is not a supported unit type".format(target))
            return
    except ValueError:
        logger.error("Could not convert the value {} {}".format(value, unit))
        return None


def check(result, response):
    """
    Returns a string of correct, incorrect, or invalid
    after comparing the conversion result and response of
    the student rounded to the ones place.
    """
    try:
        if result is None:
            return "invalid"
        elif response is not None:
            return "correct" if int(response) == int(result) else "incorrect"
        return result
    except ValueError:
        return "incorrect"
