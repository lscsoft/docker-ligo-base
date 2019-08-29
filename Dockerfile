FROM continuumio/miniconda3

LABEL name="LIGO Base - Miniconda" \
      maintainer="Duncan Macleod <duncan.macleod@ligo.org>" \
      support="Best Effort"

RUN conda update --yes conda && \
    conda config --system --prepend channels conda-forge && \
    conda install --yes \
        conda-build \
        conda-forge-pinning \
        conda-smithy \
        conda-verify
