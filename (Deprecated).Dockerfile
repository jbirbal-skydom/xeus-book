# To run the countainer 
# docker run -it -p 8888:8888 --name jupyter xeusbook:latest



FROM continuumio/miniconda3
COPY environment.yml /tmp/conda-tmp/
RUN apt-get update 
RUN apt install libarchive13 nano -y
RUN conda update -n base conda
RUN conda install mamba -n base -c conda-forge
# RUN /opt/conda/bin/conda env update -n base -f /tmp/conda-tmp/environment.yml \
#      && rm -rf /tmp/conda-tmp && conda clean -ya

RUN mamba install -y xeus-cling -c conda-forge
RUN mamba install -y jupyterlab -c conda-forge
RUN mamba install -y libpng -c conda-forge
RUN mamba install -y boost -c conda-forge

COPY ./back-end/entrypoint.sh /opt/conda/bin/entrypoint.sh

RUN chmod 755 /opt/conda/bin/entrypoint.sh

ENV CONDA_PATH=/opt/conda

#ENTRYPOINT [ "/opt/conda/bin/entrypoint.sh" ] 

WORKDIR /home/book