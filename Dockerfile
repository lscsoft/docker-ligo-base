FROM ringo/scientific

LABEL name="LIGO Base Scientific Linux 7" \
      maintainer="Philippe Grassia <philippe.grassia@ligo.org>" \
      date="20171103" \
      support="Reference Platform"


# download and install lscsoft repository
RUN yum install -y yum-plugin-ovl 

RUN rpm -ivh http://software.ligo.org/lscsoft/scientific/7/x86_64/production/lscsoft-production-config-1.3-1.el7.noarch.rpm

# download and install osg repository
RUN rpm -ivh http://repo.grid.iu.edu/osg/3.3/osg-3.3-el7-release-latest.rpm

# configure upstream git-lfs repository
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | bash

# initialise metadata
RUN yum clean all && yum makecache

# configure extra repositories
RUN yum -y install lscsoft-backports-config \
      lscsoft-epel-config \
      lscsoft-grid-config \
      lscsoft-ius-config

# setup a working shell
RUN yum -y install bash-completion && \
      yum clean all



