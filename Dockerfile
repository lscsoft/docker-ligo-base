FROM debian:jessie

LABEL name="LIGO Base Debian Jessie" \
      maintainer="Adam Mercer <adam.mercer@ligo.org>" \
      date="20170527"

# non-interactive debian installation
ENV DEBIAN_FRONTEND noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# update repository metadata
RUN apt-get update

# install apt-utils, build-essential, and wget
RUN apt-get --assume-yes install apt-utils build-essential wget

# add required repositories
RUN echo "deb http://research.cs.wisc.edu/htcondor/debian/stable/ jessie contrib" > /etc/apt/sources.list.d/condor.list
RUN echo "deb http://software.ligo.org/gridtools/debian jessie main" > /etc/apt/sources.list.d/gridtools.list
RUN echo "deb http://software.ligo.org/lscsoft/debian jessie contrib" > /etc/apt/sources.list.d/lscsoft.list

# update repository metadata
RUN apt-get update

# add software.ligo.org repo key to keychain
RUN apt-get --assume-yes --allow-unauthenticated install lscsoft-archive-keyring

# add condor repo key
RUN wget -qO - http://research.cs.wisc.edu/htcondor/debian/HTCondor-Release.gpg.key | apt-key add -

# update repository metadata
RUN apt-get update

# install git
RUN apt-get --assume-yes install git-all
