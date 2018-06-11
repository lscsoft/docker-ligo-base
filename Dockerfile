FROM scientificlinux/sl:7

LABEL name="LIGO Scientific Linux 7" \
      maintainer="Adam Mercer <adam.mercer@ligo.org>" \
      date="20180611" \
      support="Reference Platform"

# download and install lscsoft repository
RUN rpm -ivh http://software.ligo.org/lscsoft/scientific/7/x86_64/production/lscsoft-production-config-1.3-1.el7.noarch.rpm

# download and install osg repository
RUN rpm -ivh https://repo.opensciencegrid.org/osg/3.4/osg-3.4-el7-release-latest.rpm

# configure upstream git-lfs repository
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | bash

# initialise metadata
RUN yum clean all && yum makecache

# configure extra repositories
RUN yum -y install yum-priorities \
      lscsoft-backports-config \
      lscsoft-epel-config \
      lscsoft-grid-config \
      lscsoft-ius-config

# setup a working shell
RUN yum -y install bash-completion && \
      yum clean all
