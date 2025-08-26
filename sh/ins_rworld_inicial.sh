#!/bin/bash
# fecha revision   2025-08-25  23:36

logito="ins_rworld_inicial.txt"
# si ya corrio esta seccion, exit
[ -e "/home/$USER/log/$logito" ] && exit 0

# requiero que el system este instalado
[ ! -e "/home/$USER/log/ins_system.txt" ] && exit 1


source  /home/$USER/cloud-install/sh/common.sh

# instalar  R   version: 4.4.3 | released: 2025-02-28
# Documentacion  https://cran.r-project.org/

cd
R_LIBS_USER=/home/$USER/.local/lib/R/site-library
mkdir  -p $R_LIBS_USER

cat > /home/$USER/.Renviron  <<FILE
R_LIBS_USER=$R_LIBS_USER
FILE


# update indices
sudo apt update -qq
# install two helper packages we need
sudo  DEBIAN_FRONTEND=noninteractive  apt install --no-install-recommends software-properties-common dirmngr
# add the signing key (by Michael Rutter) for these repos
# To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
# Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
#wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

sudo DEBIAN_FRONTEND=noninteractive  apt install --yes --no-install-recommends r-base  r-base-dev  r-cran-devtools

Rscript --verbose  /home/$USER/cloud-install/r/test_rlang.r  /home/$USER/log/ins_rlang.txt

bitacora   "rlang"

#------------------------------------------------------------------------------
# Instalo RStudio Server    Version:  2025.05.0+496 | Released:  2025-06-05----
# Doc  https://rstudio.com/products/rstudio/download-server/debian-ubuntu/

[ ! -e "/home/$USER/log/ins_rlang.txt" ] && exit 1

cd
rstudiopack="rstudio-server-2025.05.1-513-amd64.deb"

wget  https://download2.rstudio.org/server/jammy/amd64/"$rstudiopack"


sudo  DEBIAN_FRONTEND=noninteractive  gdebi -n $rstudiopack
rm    $rstudiopack


# cambio el puerto del Rstudio Server al 80 para que se pueda acceder en aulas de universidades detras de firewalls
# Documentacion  https://support.rstudio.com/hc/en-us/articles/200552316-Configuring-the-Server
echo "www-port=80" | sudo tee -a /etc/rstudio/rserver.conf
echo "auth-timeout-minutes=0" | sudo tee -a /etc/rstudio/rserver.conf
echo "auth-stay-signed-in-days=30" | sudo tee -a /etc/rstudio/rserver.conf

echo "session-timeout-minutes=0" | sudo tee -a /etc/rstudio/rsession.conf 
sudo  rstudio-server restart

# rstudio-server status
gcloud compute firewall-rules create rstudio --allow tcp:80  --source-tags=instance-instalacion --source-ranges=0.0.0.0/0 --description="rstudio"


systemctl is-active --quiet rstudio-server
if [ ! $? -eq 0 ]; then
    echo "servicio rstudio-server no esta funcionando"
else
  fecha=$(date +"%Y%m%d %H%M%S")
  echo $fecha > /home/$USER/log/ins_rstudio.txt
fi

bitacora   "rstudio"

#------------------------------------------------------------------------------

# instalacion de  paquetes iniciales de R

[ ! -e "/home/$USER/log/ins_rlang.txt" ] && exit 1
[ ! -e "/home/$USER/log/ins_rstudio.txt" ] && exit 1

# Primera instalacion de paquetes de R , 5 minutos
Rscript --verbose  /home/$USER/cloud-install/r/instalar_paquetes_1.r  | sudo tee -a /home/$USER/install/log.txt

bitacora   "R  packages 1"

fecha=$(date +"%Y%m%d %H%M%S")
echo $fecha > /home/$USER/log/ins_rworld_inicial_packages1.txt


# grabo
fecha=$(date +"%Y%m%d %H%M%S")
echo $fecha > /home/$USER/log/$logito
