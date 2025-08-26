#!/bin/bash
# fecha revision   2025-08-25  23:36

logito="ins_pyworld_final.txt"
# si ya corrio esta seccion, exit
[ -e "/home/$USER/log/$logito" ] && exit 0

# requiero que el system este instalado
[ ! -e "/home/$USER/log/ins_system.txt" ] && exit 1
[ ! -e "/home/$USER/log/ins_pyworld_inicial.txt" ] && exit 1



source  /home/$USER/cloud-install/sh/common.sh

# Instalo Python SIN  Anaconda, Miniconda, etc-------------------------------
# Documentacion  https://docs.python-guide.org/starting/install3/linux/


source  /home/$USER/.venv/bin/activate


# instalo paquetes de Python
pip3 install  Pandas  Scikit-learn  Statsmodels       \
              Numpy  Matplotlib  fastparquet          \
              pyarrow  tables  plotly  seaborn xlrd   \
              scrapy  SciPy  wheel  testresources     \
              Requests  Selenium  PyTest  Unit        \
              dask  numba  polars  Flask 

pip3 install  duckdb  jupysql  duckdb-engine

pip3 install  XGBoost  LightGBM  CatBoost HyperOpt  optuna

pip3 install  Boruta lime

# AutoML varios
pip3 install  h2o
pip3 install  flaml
pip3 install  tpot

pip3 install evalml
pip3 install evalml --no-dependencies

# Keras
pip3 install  Keras

# librerias puntuales
pip3 install  kaggle  zulip  pika  gdown  mlflow
pip3 install  black[jupyter] category-encoders colorama featuretools holidays
pip3 install  imbalanced-learn ipywidgets kaleido nlp-primitives pmdarima scikit-optimize
pip3 install  shap sktime texttable tomli woodwork[dask]
pip3 install  nbconvert[webpdf]
pip3 install  nb_pdf_template


pip3 install  pydbus

pip3 install  shap
pip3 install  dask-expr
pip3 install  umap umap-learn 



bitacora   "python packages final"

# grabo
fecha=$(date +"%Y%m%d %H%M%S")
echo $fecha > /home/$USER/log/$logito
