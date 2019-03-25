FROM python:alpine3.9 as linting
COPY . /src
WORKDIR /src
## check style with flake8
RUN ./clean.sh && \
    
    python -m pip install -r requirements/dev.txt && \
    flake8 ptct tests

## run tests quickly with the default Python
FROM python:alpine3.9 as test
WORKDIR /src
COPY --from=linting /src .
RUN export PIP_DOWNLOAD_CACHE=/src/.pip_download_cache && \
    python -m pip install -r requirements/dev.txt && \
    python setup.py test

## check code coverage quickly with the default Python
FROM python:alpine3.9 as coverage 
WORKDIR /src
COPY --from=linting /src .
RUN export PIP_DOWNLOAD_CACHE=/src/.pip_download_cache && \
    python -m pip install -r requirements/dev.txt
RUN coverage run --source ptct setup.py test && \
    coverage report -m && \
    coverage html && \
    python pkg/browser.py htmlcov/index.html

## generate Sphinx HTML documentation, including API docs
FROM python:alpine3.9 as docs 
RUN apk --update add gcc make g++ zlib-dev
WORKDIR /src
COPY --from=linting /src .
RUN export PIP_DOWNLOAD_CACHE=/src/.pip_download_cache && \
    python -m pip install -r requirements/dev.txt
RUN make docs

## builds source and wheel package
FROM python:alpine3.9 as dist 
WORKDIR /src
COPY --from=linting /src .
RUN export PIP_DOWNLOAD_CACHE=/src/.pip_download_cache 
RUN ./clean.sh && \
    python setup.py sdist && \
    python setup.py bdist_wheel && \
    ls -l dist

FROM python:alpine3.9 as install
WORKDIR /app
COPY --from=dist /src/dist ./dist
RUN pip install $(ls dist/*.whl)

ENTRYPOINT ["ptct"]
