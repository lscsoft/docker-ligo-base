FROM centos:8

LABEL name="LIGO Base - Enterprise Linux 8" \
      maintainer="Adam Mercer <adam.mercer@ligo.org>" \
      support="Best Effort"

# enable git-lfs repository
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | bash && \
    dnf clean all

# install extra packages
RUN dnf -y install \
      bash-completion && \
    dnf clean all

# install available updates
RUN dnf -y update && dnf clean all
