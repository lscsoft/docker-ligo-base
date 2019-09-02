# sl:7 has been updated to SL 7.7, use the digest of the previous release
FROM sl@sha256:aba43907fb2fa664d5eb9daadd50034c38ea63a263bb7c97d1e683445e158caf

LABEL name="LIGO Base - Enterprise Linux 7 - Testing" \
      maintainer="Adam Mercer <adam.mercer@ligo.org>" \
      support="Reference Platform"

# stick to sl7.6 and exclude python3 updates from security repository
# this is a temporary measure whilst the SL77 and python34-python36
# transition is handled
RUN echo 7.6 > /etc/yum/vars/slreleasever
RUN echo exclude=python3* >> /etc/yum.repos.d/sl7-security.repo

# download and install standard repositories with LSCSoft Production enabled
RUN yum -y install http://software.ligo.org/lscsoft/scientific/7/x86_64/production/l/lscsoft-production-config-1.3-1.el7.noarch.rpm && \
    yum -y install  https://repo.opensciencegrid.org/osg/3.4/osg-3.4-el7-release-latest.rpm && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | bash && \
    yum clean all && yum makecache

# fix git-lfs repository for scientific linux
RUN sed -i s/scientific/el/g /etc/yum.repos.d/github_git-lfs.repo

# install available updates
RUN yum -y update

# configure extra repositories
RUN yum -y install \
      bash-completion \
      yum-priorities \
      lscsoft-backports-config \
      lscsoft-epel-config \
      lscsoft-grid-config \
      lscsoft-ius-config \
      lscsoft-testing-config && \
    yum clean all
