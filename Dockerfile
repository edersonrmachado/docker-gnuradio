FROM ubuntu:18.04  

# set pybombs env variable
ENV PyBOMBS_prefix GNURADIO
ENV DEBIAN_FRONTEND=noninteractive

#install packages
RUN apt-get update -q
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
  --no-install-recommends \
  build-essential \ 
  apt-utils \
  git \
  python \
  python-dev \
  python-pip \
  python-apt \
  python-numpy 
# Install PyBOMBS
RUN pip install --upgrade pip
RUN pip install --upgrade git+https://github.com/gnuradio/pybombs.git

# Config pybombs and install gnuradio 3.7
RUN apt-get -qq update \
  && pybombs auto-config \
  && pybombs config makewidth 2 \
  && pybombs recipes add-defaults \
  && pybombs -vv prefix init ${PyBOMBS_prefix} -R gnuradio-stable

# clear local repository, packages that are no longer requested, providing disk space
RUN rm -rf /tmp/* && apt-get -y autoremove --purge \
  && apt-get -y clean && apt-get -y autoclean

ENTRYPOINT ["/bin/bash"] 
