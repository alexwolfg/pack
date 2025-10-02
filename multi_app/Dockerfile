FROM jfrog.ad-alliance.biz/docker-hub/python:3.10-slim-buster AS builder

#Make sure the latest version of PyPA (Python package builder) is installed 
RUN python -m pip install build

WORKDIR /app

COPY paquete_minimo/ src/

RUN python -m build -o . --wheel

CMD ["/bin/sh", "-c", "bash"]

