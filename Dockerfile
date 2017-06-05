FROM debian:jessie

LABEL name="LIGO Base Debian Jessie" \
      maintainer="Adam Mercer <adam.mercer@ligo.org>" \
      date="20170530" \
      support="Reference Platform"

# ensure non-interactive debian installation
ENV DEBIAN_FRONTEND noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Add required repositories
RUN echo "deb http://research.cs.wisc.edu/htcondor/debian/stable jessie contrib" > /etc/apt/sources.list.d/condor.list
RUN echo "deb http://software.ligo.org/gridtools/debian jessie main" > /etc/apt/sources.list.d/gridtools.list
RUN echo "deb http://software.ligo.org/lscsoft/debian jessie contrib" > /etc/apt/sources.list.d/lscsoft.list

# add LIGO and HTCondor signing keys
RUN apt-key adv --keyserver pgp.mit.edu --recv-key 8325FECB83821E31D3582A69CE050D236DB6FA3F
RUN apt-key adv --keyserver pgp.mit.edu --recv-key 4B9D355DF3674E0E272D2E0A973FC7D2670079F6

# Setup a working bash shell
RUN apt-get update && apt-get install bash-completion
