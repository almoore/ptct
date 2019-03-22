#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""The setup script."""

from setuptools import setup, find_packages

with open('README.rst') as readme_file:
    readme = readme_file.read()

with open('HISTORY.rst') as history_file:
    history = history_file.read()

requirements = open('requirements/base.txt').readlines()

setup_requirements = ['pytest-runner', "setuptools>=21.0.0" ]

test_requirements = open('requirements/dev.txt').readlines()

setup(
    name='ptct',
    url='https://github.com/almoore/ptct',
    version='0.1.0',
    author="Alex Moore",
    author_email='alexander.g.moore1@gmail.com',
    description="Python program to convert temperature between Kelvin, Celsius, Fahrenheit",
    entry_points={
        'console_scripts': [
            'ptct=ptct.cli:main',
        ],
    },
    install_requires=requirements,
    license="Apache Software License 2.0",
    long_description=readme + '\n\n' + history,
    include_package_data=True,
    keywords='ptct temperature conversion',
    packages=find_packages(include=['ptct']),
    setup_requires=setup_requirements,
    test_suite='tests',
    tests_require=test_requirements,
    zip_safe=False,
    classifiers=[
        'Intended Audience :: Developers',
        'License :: OSI Approved :: Apache Software License',
        'Natural Language :: English',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.4',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
    ],
)
