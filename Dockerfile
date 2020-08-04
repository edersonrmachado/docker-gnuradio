FROM ubuntu:18.04  

# set pybombs env variable
ENV PyBOMBS_prefix GNURADIO

RUN apt-get update && apt-get install -y \
  apt-utils \
  git \
  python \
  python-pip 

# Install PyBOMBS
RUN pip install --upgrade git+https://github.com/gnuradio/pybombs.git

# Config pybombs and install gnuradio 3.7
RUN apt-get -qq update \
  && pybombs auto-config \
  && pybombs recipes add-defaults \
  && pybombs -vv prefix init ${PyBOMBS_prefix} -R gnuradio-stable

ENTRYPOINT ["/bin/bash"] 