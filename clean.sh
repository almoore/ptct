#!/bin/sh

set -e

clean_build() {
    echo "Removing build artifacts"
    rm -fr build/
    rm -fr dist/
    rm -fr .eggs/
    find . -name '*.egg-info' -exec rm -fr {} +
    find . -name '*.egg' -exec rm -f {} +
}

clean_pyc() {
    echo "Removing Python file artifacts"
    find . -name '*.pyc' -exec rm -f {} +
    find . -name '*.pyo' -exec rm -f {} +
    find . -name '*~' -exec rm -f {} +
    find . -name '__pycache__' -exec rm -fr {} +
}

clean_test() {
    echo "Removing test and coverage artifacts"
    rm -fr .tox/
    rm -f .coverage
    rm -fr htmlcov/
    rm -fr .pytest_cache
}

clean() {
    ## remove all build, test, coverage and Python artifacts
    clean_build
    clean_pyc
    clean_test
    echo "Done"
}

clean
