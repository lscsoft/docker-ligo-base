FROM continuumio/miniconda3

LABEL name="LIGO Base - Miniconda" \
      maintainer="Duncan Macleod <duncan.macleod@ligo.org>" \
      support="Best Effort"

RUN /opt/conda/bin/conda update --yes conda && \
    /opt/conda/bin/conda config --system --prepend channels conda-forge && \
    /opt/conda/bin/conda config --system --append channels lscsoft && \
    /opt/conda/bin/conda install --yes \
        conda-build \
        conda-forge-pinning \
        conda-smithy \
        conda-verify && \
    /opt/conda/bin/conda clean -afy
