FROM mambaorg/micromamba

RUN mkdir /home/mambauser/book && cd /home/mambauser/book
WORKDIR /home/mambauser/book
COPY --chown=$MAMBA_USER:$MAMBA_USER environment/newT.yaml /home/mambauser/book/newT.yaml
COPY ./docs/book /home/mambauser/book


RUN micromamba install -y -n base -f /home/mambauser/book/newT.yaml && \
    micromamba clean --all --yes


################################ Run any apt installs that I may need #####################################
USER root
# RUN apt-get update && apt-get install -y \
#     nano 

COPY ./back-end/entrypoint.sh /opt/conda/bin/entrypoint.sh

RUN micromamba install -n base -c conda-forge --no-deps "boost>=1.77", "boost-cpp>=1.77"

RUN chmod 755 /opt/conda/bin/entrypoint.sh
#####################################################################################################
USER $MAMBA_USER


###############  Start Jupyter ######################################################################## 


ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "/opt/conda/bin/entrypoint.sh" ] 

## docker run -it -p 8989:8989 --name jupyterC xeusbook:c
## docker  exec -it -u root jupyterC /bin/bash
## http://localhost:8989/lab