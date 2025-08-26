#!/bin/bash
# fecha revision   2025-08-25  23:36

logito="ins_lightgbm.txt"
# si ya corrio esta seccion, exit
[ -e "/home/$USER/log/$logito" ] && exit 0

# requiero que el system este instalado
[ ! -e "/home/$USER/log/ins_rlang.txt" ] && exit 1


source  /home/$USER/cloud-install/sh/common.sh

source  /home/$USER/cloud-install/sh/common.sh
cd
rm -rf  LightGBM
git clone --recursive  https://github.com/Microsoft/LightGBM
cd LightGBM
Rscript ./build_r.R
cd
rm -rf  LightGBM

bitacora   "R  lightgbm"

Rscript --verbose  /home/$USER/cloud-install/r/instalar_paquetes_3.r
bitacora   "R  packages 3"


bitacora   "lightgbm"

# grabo
fecha=$(date +"%Y%m%d %H%M%S")
echo $fecha > /home/$USER/log/$logito
