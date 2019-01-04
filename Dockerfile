FROM debian:buster

LABEL name="LIGO Base Debian Buster" \
      maintainer="Adam Mercer <adam.mercer@ligo.org>" \
      date="20190104" \
      support="Upcoming Reference Platform"

# ensure non-interactive debian installation
ENV DEBIAN_FRONTEND noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# support https repositories
RUN apt-get update && \
    apt-get --assume-yes install \
      apt-transport-https \
      apt-utils \
      bash-completion \
      curl \
      lsb-release \
      wget \
      gnupg && \
    apt-get clean

# add main CVMFS repository
RUN wget https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest_all.deb && \
    dpkg -i cvmfs-release-latest_all.deb && \
    rm -f cvmfs-release-latest_all.deb

# add CVMFS contrib repository (OSG config and X509 helper)
RUN wget https://ecsft.cern.ch/dist/cvmfs/cvmfs-contrib-release/cvmfs-contrib-release-latest_all.deb && \
    dpkg -i cvmfs-contrib-release-latest_all.deb && \
    rm -f cvmfs-contrib-release-latest_all.deb

# add git-lfs repo
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash

# add HTCondor repo when it is available

# Add other repos
RUN wget http://software.ligo.org/lscsoft/debian/pool/contrib/l/lscsoft-archive-keyring/lscsoft-archive-keyring_2016.06.20-2_all.deb && \
    dpkg -i lscsoft-archive-keyring_2016.06.20-2_all.deb && \
    rm -f lscsoft-archive-keyring_2016.06.20-2_all.deb

RUN echo "deb http://software.ligo.org/gridtools/debian buster main" > /etc/apt/sources.list.d/gridtools.list && \
    echo "deb http://software.ligo.org/lscsoft/debian buster contrib" > /etc/apt/sources.list.d/lscsoft.list
