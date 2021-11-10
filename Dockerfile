FROM ubuntu:20.04

# install miniconda
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* && \
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p /root/miniconda

# install node
ENV PATH=/root/miniconda/bin:$PATH
ENV CONDA_AUTO_UPDATE_CONDA="false"
RUN conda install -y nodejs=14.*

RUN mkdir /app && cd /app && npm install onnxruntime-node

COPY ./src /app

ENTRYPOINT [ "/root/miniconda/bin/node", "/app/app.js"]
