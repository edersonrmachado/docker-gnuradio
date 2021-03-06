FROM ubuntu:18.04  

# set pybombs env variable
ENV PyBOMBS_prefix GNURADIO
ENV DEBIAN_FRONTEND=noninteractive

#install packages
RUN apt-get update -q
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
  --no-install-recommends \
  build-essential \ 
  pkg-config \
  apt-utils \
  git \
  libcppunit-dev \
  libgtk2.0-dev \
  libgtk2.0-0 \
  libqt4-dev \
  libqwt-dev \
  pyqt4-dev-tools \
  libqwt5-qt4 \
  python \
  python-gtk2 \
  python-wxgtk3.0 \
  python-cheetah \
  python-sphinx \
  python-dev \
  python-pip \
  python-apt \
  python-numpy \
  python-setuptools

# Install PyBOMBS
RUN pip install --upgrade pip
RUN pip install --upgrade git+https://github.com/gnuradio/pybombs.git

# Config PyBOMBS and install gnuradio 3.7
RUN apt-get -qq update \
  && pybombs auto-config \
  && pybombs config --package pygtk forceinstalled true \
  && pybombs config makewidth 2 \
  && pybombs recipes add-defaults \
  && pybombs -vv prefix init ${PyBOMBS_prefix} -R gnuradio-stable

# Clear local repository, packages that are no longer requested, providing disk space
RUN rm -rf /tmp/* && apt-get -y autoremove --purge \
  && apt-get -y clean && apt-get -y autoclean

ENTRYPOINT ["/bin/bash"] 