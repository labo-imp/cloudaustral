#!/bin/bash
# fecha revision   2025-08-25  23:36

logito="ins_pyworld_inicial.txt"
# si ya corrio esta seccion, exit
[ -e "/home/$USER/log/$logito" ] && exit 0

# requiero que el system este instalado
[ ! -e "/home/$USER/log/ins_system.txt" ] && exit 1


source  /home/$USER/cloud-install/sh/common.sh

# Instalo Python SIN  Anaconda, Miniconda, etc-------------------------------
# Documentacion  https://docs.python-guide.org/starting/install3/linux/

export PATH="$PATH:/home/$USER/.local/bin"
echo  "export PATH=/home/\$USER/.local/bin:\$PATH"  >>  /home/$USER/.bashrc
chmod u+x /home/$USER/.bashrc
source /home/$USER/.bashrc 


sudo  apt-get update

#--------------------------------------
# Python 3.11
cd
wget https://www.python.org/ftp/python/3.11.13/Python-3.11.13.tgz
tar xzvf Python-3.11.13.tgz
cd Python-3.11.13
./configure
make
sudo make install
cd
rm /home/$USER/Python-3.11.13.tgz
sudo rm -rf /home/$USER/Python-3.11.13


# creo el Virtual Environment 3.11
cd
python3.11  -m venv  .venv311

# activo python 3.11
source  /home/$USER/.venv311/bin/activate

# actualizo  pip  de 3.11
pip3 install --upgrade pip
pip3 install setuptools

# Pycaret en  Python 3.11
pip3 install  pycaret[full]

# instalo  datatable desde su repo   en  Python  3.11
pip3 install  datatable

# instalo  auto-sklearn   en  Python  3.11
# pip3 install numpy scipy scikit-learn pandas dask distributed joblib psutil lockfile
# pip install pyrfr
# pip3 install  auto-sklearn

# desactivo Python 3.11
deactivate

#--------------------------------------
# Python 3.12
cd
wget https://www.python.org/ftp/python/3.12.10/Python-3.12.10.tgz
tar xzvf Python-3.12.10.tgz
cd Python-3.12.10
./configure
make
sudo make install
cd
rm /home/$USER/Python-3.12.10.tgz
sudo rm -rf /home/$USER/Python-3.12.10

# creo el Virtual Environment 3.12
cd
python3.12  -m venv  .venv312

# activo python 3.12
source  /home/$USER/.venv312/bin/activate

# actualizo  pip  de 3.12
pip3 install --upgrade pip
pip3 install setuptools

# instalo AutoGluon en  Python  3.12
pip3 install -U setuptools wheel
pip3 install autogluon --extra-index-url https://download.pytorch.org/whl/cpu

# instalo  datatable desde su repo   en  Python  3.12
pip3 install  datatable

pip3 install  tensorflow  Keras

# desactivo Python 3.12
deactivate



#--------------------------------------
# Python 3.13.5  2025-07-10
cd
wget https://www.python.org/ftp/python/3.13.5/Python-3.13.5.tgz
tar xzvf Python-3.13.5.tgz
cd Python-3.13.5
./configure
make
sudo make install
cd
rm /home/$USER/Python-3.13.5.tgz
sudo rm -rf /home/$USER/Python-3.13.5


sudo  DEBIAN_FRONTEND=noninteractive  apt-get --yes install \
        python3-pip  python3-dev  ipython3  python3.13-venv


python3  /home/$USER/cloud-install/py/test_python.py  /home/$USER/log/ins_python.txt


[ ! -e "/home/$USER/log/ins_python.txt" ] && exit 1

# creo el Virtual Environment
cd
python3     -m venv  .venv


# activo python 3.13
source  /home/$USER/.venv/bin/activate

# actualizo  pip
pip3 install --upgrade pip
pip3 install setuptools
pip3 install -U setuptools wheel

bitacora   "Python"

# instalo paquetes iniciales de Python
pip3 install  kaggle  zulip



bitacora   "python packages"

# grabo
fecha=$(date +"%Y%m%d %H%M%S")
echo $fecha > /home/$USER/log/$logito
