FROM sl:7

LABEL name="LIGO Base - Enterprise Linux 7 - Testing" \
      maintainer="Adam Mercer <adam.mercer@ligo.org>" \
      support="Reference Platform"

# download and install standard repositories with LSCSoft Production enabled
RUN yum -y install http://software.ligo.org/lscsoft/scientific/7/x86_64/production/l/lscsoft-production-config-1.3-1.el7.noarch.rpm && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | bash

# add osg repository
RUN echo "[osg]" > /etc/yum.repos.d/osg.repo && \
    echo "name=OSG Software for Enterprise Linux 7 - \$basearch" >> /etc/yum.repos.d/osg.repo && \
    echo "baseurl=https://repo.opensciencegrid.org/osg/3.5/el7/release/\$basearch" >> /etc/yum.repos.d/osg.repo && \
    echo "failovermethod=priority" >> /etc/yum.repos.d/osg.repo && \
    echo "priority=98" >> /etc/yum.repos.d/osg.repo && \
    echo "enabled=1" >> /etc/yum.repos.d/osg.repo && \
    echo "gpgcheck=1" >> /etc/yum.repos.d/osg.repo && \
    echo "gpgkey=http://repo.opensciencegrid.org/osg/3.5/RPM-GPG-KEY-OSG" >> /etc/yum.repos.d/osg.repo && \
    echo "exclude=*condor*" >> /etc/yum.repos.d/osg.repo

# add lscsoft-backports repository
RUN echo "[lscsoft-backports-testing]" > /etc/yum.repos.d/lscsoft-backports-testing.repo && \
    echo "name = lscsoft-backports-testing" >> /etc/yum.repos.d/lscsoft-backports-testing.repo && \
    echo "baseurl = http://software.ligo.org/lscsoft/scientific/\$releasever/\$basearch/backports-testing" >> /etc/yum.repos.d/lscsoft-backports-testing.repo && \
    echo "enabled = 1" >> /etc/yum.repos.d/lscsoft-backports-testing.repo && \
    echo "gpgcheck = 0" >> /etc/yum.repos.d/lscsoft-backports-testing.repo && \
    echo "failovermethod = priority" >> /etc/yum.repos.d/lscsoft-backports-testing.repo && \
    echo "priority = 97" >> /etc/yum.repos.d/lscsoft-backports-testing.repo

# add WANdisco git repository
RUN echo "[wandisco-git]" > /etc/yum.repos.d/wandisco-git.repo && \
    echo "name=Wandisco GIT Repository" >> /etc/yum.repos.d/wandisco-git.repo && \
    echo "baseurl=http://opensource.wandisco.com/centos/7/git/\$basearch/" >> /etc/yum.repos.d/wandisco-git.repo && \
    echo "enabled=1" >> /etc/yum.repos.d/wandisco-git.repo && \
    echo "gpgcheck=1" >> /etc/yum.repos.d/wandisco-git.repo && \
    echo "gpgkey=http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco" >> /etc/yum.repos.d/wandisco-git.repo

# fix git-lfs repository for scientific linux
RUN sed -i s/scientific/el/g /etc/yum.repos.d/github_git-lfs.repo

# install available updates
RUN yum clean all && yum makecache && yum -y update

# configure extra repositories
RUN yum -y install \
      bash-completion \
      yum-priorities \
      lscsoft-backports-config \
      lscsoft-epel-config \
      lscsoft-grid-config \
      lscsoft-testing-config && \
    yum clean all
