FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
  git \
  python \
  python-pip   
ENTRYPOINT ["/bin/bash"]