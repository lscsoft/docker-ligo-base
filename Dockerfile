FROM debian:stretch

LABEL name="LIGO Base Debian Stretch" \
      maintainer="Adam Mercer <adam.mercer@ligo.org>" \
      date="20170530" \
      support="Best Effort"

# non-interactive debian installation
ENV DEBIAN_FRONTEND noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# update repository metadata
RUN apt-get update

# install apt-utils, build-essential, and wget
RUN apt-get --assume-yes install apt-utils build-essential wget

# add required repositories
#RUN echo "deb http://research.cs.wisc.edu/htcondor/debian/stable/ stretch contrib" > /etc/apt/sources.list.d/condor.list
RUN echo "deb http://software.ligo.org/gridtools/debian stretch main" > /etc/apt/sources.list.d/gridtools.list
RUN echo "deb http://software.ligo.org/lscsoft/debian stretch contrib" > /etc/apt/sources.list.d/lscsoft.list

# update repository metadata
RUN apt-get update

# add software.ligo.org repo key to keychain
RUN apt-key adv --keyserver pgp.mit.edu --recv-key 8325FECB83821E31D3582A69CE050D236DB6FA3F

# add condor repo key to keychain
#RUN apt-key adv --keyserver pgp.mit.edu --recv-key 4B9D355DF3674E0E272D2E0A973FC7D2670079F6

# update repository metadata
RUN apt-get update

# install lscsoft-archive-keyring
RUN apt-get --assume-yes install lscsoft-archive-keyring

# install git
RUN apt-get --assume-yes install git
