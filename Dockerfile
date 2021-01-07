FROM centos:8

LABEL name="LIGO Base - Enterprise Linux 8 - Testing"
LABEL maintainer="Adam Mercer <adam.mercer@ligo.org>"
LABEL support="Best Effort"

# enable extra repositories
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | bash && \
    dnf -y install http://software.ligo.org/lscsoft/centos/8/production/x86_64/os/l/lscsoft-production-config-8-4.el8.noarch.rpm && \
    dnf -y install 'dnf-command(config-manager)' && \
    dnf config-manager --set-enabled powertools && \
    dnf clean all

# enable htcondor repo
RUN curl -LO https://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor && \
    rpm --import RPM-GPG-KEY-HTCondor && \
    curl -Lo /etc/yum.repos.d/htcondor-stable-rhel8.repo https://research.cs.wisc.edu/htcondor/yum/repo.d/htcondor-stable-rhel8.repo

# add osg repository
RUN echo "[osg]" > /etc/yum.repos.d/osg.repo && \
    echo "name=OSG Software for Enterprise Linux 8 - \$basearch" >> /etc/yum.repos.d/osg.repo && \
    echo "baseurl=https://repo.opensciencegrid.org/osg/3.5/el8/release/\$basearch" >> /etc/yum.repos.d/osg.repo && \
    echo "failovermethod=priority" >> /etc/yum.repos.d/osg.repo && \
    echo "enabled=1" >> /etc/yum.repos.d/osg.repo && \
    echo "gpgcheck=1" >> /etc/yum.repos.d/osg.repo && \
    echo "gpgkey=http://repo.opensciencegrid.org/osg/RPM-GPG-KEY-OSG" >> /etc/yum.repos.d/osg.repo && \
    echo "exclude=*condor*" >> /etc/yum.repos.d/osg.repo

# install extra packages
RUN dnf -y install \
      bash-completion \
      epel-release \
      lscsoft-production-debug-config \
      lscsoft-backports-config \
      lscsoft-backports-debug-config \
      lscsoft-testing-config \
      lscsoft-testing-debug-config \
      lscsoft-backports-testing-config \
      lscsoft-backports-testing-debug-config && \
    dnf clean all

# install available updates
RUN dnf -y update && dnf clean all
