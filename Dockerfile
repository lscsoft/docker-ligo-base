FROM debian:bullseye

LABEL name="LIGO Base - Debian Bullseye"
LABEL maintainer="Adam Mercer <adam.mercer@ligo.org>"
LABEL support="Unsupported"

# ensure non-interactive debian installation
ENV DEBIAN_FRONTEND noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# install available updates
RUN apt-get update && apt-get --assume-yes upgrade && apt-get clean

# support https repositories
RUN apt-get --assume-yes install \
      apt-transport-https \
      apt-utils \
      bash-completion \
      curl \
      lsb-release \
      wget && \
    apt-get clean

# Add other repos
RUN wget http://software.ligo.org/lscsoft/debian/pool/contrib/l/lscsoft-archive-keyring/lscsoft-archive-keyring_2016.06.20-2_all.deb && \
    apt --assume-yes install ./lscsoft-archive-keyring_2016.06.20-2_all.deb && \
    rm -f lscsoft-archive-keyring_2016.06.20-2_all.deb

RUN echo "deb http://software.ligo.org/gridtools/debian bullseye main" > /etc/apt/sources.list.d/gridtools.list && \
    echo "deb [trusted=yes] https://galahad.aei.mpg.de/lsc-amd64-bullseye ./" > /etc/apt/sources.list.d/lscsoft.list
