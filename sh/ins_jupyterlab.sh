#!/bin/bash
# fecha revision   2025-08-25  23:36

logito="ins_jupyterlab.txt"
# si ya corrio esta seccion, exit
[ -e "/home/$USER/log/$logito" ] && exit 0

# requiero que el system este instalado
[ ! -e "/home/$USER/log/ins_pyworld_final.txt" ] && exit 1


source  /home/$USER/cloud-install/sh/common.sh

# instalo  Jupyter Labs, estando DENTRO  del Virtual Environment ----------------
# Documentacion  https://jupyterlab.readthedocs.io/en/stable/getting_started/installation.html
cd
source  /home/$USER/.venv/bin/activate

pip3 install  pygments  oauthlib
 
# la instalacion de jupyter lab
pip3  install jupyterlab

# instalo nvm  version  0.40.3  del  2025-03-23
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.40.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install --lts


# instalo extensiones de Jupyter Lab
jupyter labextension install  jupyterlab-spreadsheet
jupyter labextension install  jupyterlab-chart-editor
jupyter labextension install  @jupyterlab/toc


# instalo git para Jupyter Lab
pip3 install --upgrade  jupyterlab  jupyterlab-git

# por supuesto, la instalacion de Jupyter Lab ya instala el kernel de Python

# para que se pueda ingresar a  Jupyter en forma remota
mkdir -p /home/$USER/.jupyter/
cp  /home/$USER/cloud-install/py/jupyter_server_config.py   /home/$USER/.jupyter/jupyter_server_config.py

mkdir /home/$USER/.venv/.jupyter
cp  /home/$USER/cloud-install/py/jupyter_server_config.py   /home/$USER/.venv/.jupyter/jupyter_server_config.py

pip3  install  --upgrade nbconvert


# abro el puerto  8888  en Google Cloud  para Jupyter
# Documentacion  https://cloud.google.com/vpc/docs/using-firewalls#gcloud

gcloud compute firewall-rules create jupyter --allow tcp:8888 --source-tags=instance-instalacion --source-ranges=0.0.0.0/0 --description="jupyter"



bitacora   "JupyterLab"

# grabo
fecha=$(date +"%Y%m%d %H%M%S")
echo $fecha > /home/$USER/log/$logito
