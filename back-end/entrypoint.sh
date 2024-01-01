#!/usr/bin/env bash

# mkdir -p  $HOME
# source /root/.bashrc
/opt/conda/bin/jupyter lab --port=8989 --no-browser --allow-root  --ip='*' --NotebookApp.token='1234' --NotebookApp.password='inspire' 