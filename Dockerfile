FROM python:3.10-slim AS builder

RUN python -m pip install build 

WORKDIR /app

COPY . .

RUN python -m build . --wheel

FROM ubuntu:22.04

WORKDIR /app

RUN apt update \
    && apt install -y --no-install-recommends python3 python3-pip sudo vim curl \
    && apt -y upgrade 

#Configure container for using pip install of the wheel. Add user to not execute the copy as a root.
#Need to add the user to the sudo group to execute the apt-get clean and autoremove below
ARG USER=alelobo
RUN useradd -m -u 1000 ${USER} && echo "${USER}:${USER}" | chpasswd && adduser ${USER} sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ${USER}
ARG HOME=/home/${USER}

RUN rm -rf /tmp/* 
RUN sudo apt-get clean \
    && sudo apt-get autoremove

WORKDIR ${HOME}
# Adding the package to the PATH to avoid following warning: WARNING: The script multi is installed in '/home/alelobo/.local/bin' which is not on PATH.
ENV PATH="$PATH:${HOME}/.local/bin"

COPY --chown=${USER} --from=builder app/dist/* .

RUN pip install *.whl \
    && rm -rf ${HOME}/*.whl

CMD ["/bin/sh", "-c", "bash"]