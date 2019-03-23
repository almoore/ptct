FROM python:alpine3.9 as linting
COPY . /src
WORKDIR /src
## check style with flake8
RUN ./clean.sh && \
    pip install -r requirements/dev.txt && \
    flake8 ptct tests

## run tests quickly with the default Python
FROM python:alpine3.9 as test
COPY --from=linting /src /
WORKDIR /src
RUN python setup.py test

## run tests on every Python version with tox
FROM n42org/tox as tox
COPY --from=linting /src /
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
