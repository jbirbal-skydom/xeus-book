
FROM continuumio/miniconda3
COPY mambaenv.yml /tmp/conda-tmp/
RUN conda update -n base conda
RUN apt-get update 
RUN apt install libarchive13 nano -y
RUN conda install mamba -n base -c conda-forge
#RUN mamba env update -n base -f /tmp/conda-tmp/mambaenv.yml \
#    && rm -rf /tmp/conda-tmp && mamba clean --all --yes
# RUN mamba install -y -n base -c conda-forge \
#        libpng \
#        xeus-cling \
#        opencv \
#        jupyterlab && \
#     micromamba clean --all --yes

COPY ./back-end/entrypoint.sh /opt/conda/bin/entrypoint.sh

RUN chmod 755 /opt/conda/bin/entrypoint.sh

ENV CONDA_PATH=/opt/conda

#ENTRYPOINT [ "/opt/conda/bin/entrypoint.sh" ] 

WORKDIR /home/book
EXPOSE 8989