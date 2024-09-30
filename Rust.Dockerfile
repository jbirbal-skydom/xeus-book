FROM mambaorg/micromamba

RUN mkdir /home/mambauser/book && cd /home/mambauser/book
WORKDIR /home/mambauser/book
COPY --chown=$MAMBA_USER:$MAMBA_USER environment/envRust.yaml /home/mambauser/book/envRust.yaml
COPY ./docs/book /home/mambauser/book


RUN micromamba install -y -n base -f /home/mambauser/book/envRust.yaml && \
    micromamba clean --all --yes


################################ Run any apt installs that I may need #####################################
USER root

 RUN apt-get update && apt-get install -y \
     nano \
     curl \
     git
#     cmake \
#     liblapack-dev \
#     pkg-config \
#     libssl-dev \

COPY ./back-end/entrypointRust.sh /opt/conda/bin/entrypointRust.sh
ENV PATH="/opt/conda/bin/:${PATH}"
# ENV PATH="/root/.cargo/bin:${PATH}"
# RUN cargo install --locked evcxr_jupyter
# RUN evcxr_jupyter --install



RUN chmod 755 /opt/conda/bin/entrypointRust.sh
RUN chown -R mambauser:mambauser /home/mambauser/book

#####################################################################################################
USER $MAMBA_USER

# kernel install the into a user local directory
RUN cargo install --locked evcxr_jupyter  
ENV PATH="/home/mambauser/.cargo/bin:${PATH}"
RUN evcxr_jupyter --install


###############     Extra      #######################################################################

RUN pip install openpyxl
RUN pip install pandas
RUN pip install matplotlib
RUN pip install numpy
RUN pip install seaborn
RUN pip install scikit-learn
RUN pip install scipy
RUN pip install sympy
RUN pip install scikit-image
RUN pip install --upgrade jupyterlab jupyterlab-git

###############  Start Jupyter ######################################################################## 


ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "/opt/conda/bin/entrypointRust.sh" ] 
#

################   Run   ###########################

## docker run -it -p 8990:8990 --name jupyterRust xeusbook:Rust
## docker  exec -it -u root jupyterRust /bin/bash
## http://localhost:8990/lab