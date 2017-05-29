FROM centos:centos7

LABEL name="LIGO Base Enterprise Linux 7" \
      maintainer="Adam Mercer <adam.mercer@ligo.org>" \
      date="20170529" \
      support="Reference Platform"

# download and install lscsoft repository
RUN rpm -ivh http://software.ligo.org/lscsoft/scientific/7/x86_64/production/lscsoft-production-config-1.3-1.el7.noarch.rpm

# download ans install osg repository
RUN rpm -ivh http://repo.grid.iu.edu/osg/3.3/osg-3.3-el7-release-latest.rpm

# initialise metadata
RUN yum clean all
RUN yum makecache

# configure extra repositories
RUN yum -y install lscsoft-backports-config \
      lscsoft-epel-config \
      lscsoft-grid-config

# update metadata
RUN yum clean all
RUN yum makecache

# install "Development Tools" yumgroup
RUN yum groups mark convert
RUN yum -y groups install "Development Tools"

# enable ius repository
RUN yum -y install lscsoft-ius-config

# switch to ius git
RUN yum -y remove git
RUN yum -y install git2u
