FROM python:3.10-slim AS builder

RUN python -m pip install build 

WORKDIR /app

COPY . .

RUN python -m build . --wheel

FROM ubuntu:22.04

WORKDIR /app

RUN apt update \
    && apt -y upgrade \
    && apt install -y --no-install-recommends python3 python3-pip sudo vim curl

#Configure container for using pip install of the wheel
ARG USER=alelobo
RUN useradd -ms /bin/bash -u 1000 ${USER} && echo "${USER}:${USER}" | chpasswd && adduser ${USER} sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#USER ${USER}
#ARG HOME=/home/${USER}

COPY --chown=${USER} --from=builder app/dist/* /app/

RUN pip install *.whl

CMD ["/bin/sh", "-c", "bash"]