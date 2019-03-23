FROM python:alpine3.9 as linting
COPY . /src
WORKDIR /src
## check style with flake8
RUN ./clean.sh && \
    export PIP_DOWNLOAD_CACHE=/src/.pip_download_cache && \
    python -m pip install -r requirements/dev.txt && \
    flake8 ptct tests

## run tests quickly with the default Python
FROM python:alpine3.9 as test
WORKDIR /src
COPY --from=linting /src .
RUN export PIP_DOWNLOAD_CACHE=/src/.pip_download_cache && \
    python -m pip install -r requirements/dev.txt && \
    python setup.py test

## run tests on every Python version with tox
FROM alexgmoore/python:3-alpine-tox as tox
WORKDIR /src
# COPY --from=linting /src .
COPY . /src
RUN tox

## check code coverage quickly with the default Python
FROM python:alpine3.9 as coverage 
RUN coverage run --source ptct setup.py test && \
    coverage report -m && \
    coverage html && \
    python pkg/browser.py htmlcov/index.html

## generate Sphinx HTML documentation, including API docs
FROM python:alpine3.9 as docs 
RUN apk --update add gcc make g++ zlib-dev
RUN make docs

## compile the docs watching for changes
FROM python:alpine3.9 as servedocs
COPY --from=docs /src/docs .
RUN make servedocs
# watchmedo shell-command -p '*.rst' -c '$(MAKE) -C docs html' -R -D .

## builds source and wheel package
FROM python:alpine3.9 as dist 

WORKDIR /src
RUN ./clean.sh && \
    python setup.py sdist && \
    python setup.py bdist_wheel && \
    ls -l dist

## package and upload a release
FROM python:alpine3.9 as release
WORKDIR /src
COPY --from=dist /src/dist .
RUN twine upload dist/*

FROM python:alpine3.9 as install
WORKDIR /app
COPY --from=dist /src/dist .
RUN pip install dist/*.whl
