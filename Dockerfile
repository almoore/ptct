FROM python:alpine3.9 as builder

COPY . /app
WORKDIR /app
RUN ./clean.sh
RUN pip install .

## check style with flake8
FROM python:alpine3.9 as linting

WORKDIR /app
RUN flake8 ptct tests

## run tests quickly with the default Python
FROM python:alpine3.9 as test
WORKDIR /app
RUN python setup.py test

## run tests on every Python version with tox
FROM python:alpine3.9 as test-all
RUN tox

## check code coverage quickly with the default Python
FROM python:alpine3.9 as coverage 
RUN coverage run --source ptct setup.py test&& \
    coverage report -m&& \
    coverage html&& \
    $(BROWSER) htmlcov/index.html

## generate Sphinx HTML documentation, including API docs
FROM python:alpine3.9 as docs 
RUN rm -f docs/ptct.rst&& \
    rm -f docs/modules.rst&& \
    sphinx-apidoc -o docs/ ptct&& \
    $(MAKE) -C docs clean&& \
    $(MAKE) -C docs html&& \
    $(BROWSER) docs/_build/html/index.html

## compile the docs watching for changes
FROM python:alpine3.9 as servedocs 
RUN watchmedo shell-command -p '*.rst' -c '$(MAKE) -C docs html' -R -D .

## package and upload a release
FROM python:alpine3.9 as release 
RUN twine upload dist/*

## builds source and wheel package
FROM python:alpine3.9 as dist 
RUN ./clean.sh && \
    python setup.py sdist && \
    python setup.py bdist_wheel && \
    ls -l dist
