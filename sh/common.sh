#!/bin/bash
# fecha revision   2025-08-25  23:36

webfiles="https://storage.googleapis.com/open-courses/austral2025-af91"


script_instalar2="instalar-ba02.sh"
script_final="final-ba.sh"
script_finalzzzz="final-zzzz-ba.sh"

dataset1="gerencial_competencia_2025.csv.gz"
dataset2="analistajr_competencia_2025.csv.gz"
dataset3="analistasr_competencia_2025.csv.gz"
dataset4="dataset_pequeno.csv"
pseudopublic="list"

export zulipbot="GoogleCloud-bot@austral2025.zulip.rebelare.com:01VXAC02ESF98VlImLjZIysfPtORMCsX"
export zulipurl="https://austral2025.zulip.rebelare.com/api/v1/messages"

kaggleprueba="102_kaggle_prueba.r"

kaggle_competencia_sr="labo-i-2025-ba-analista-sr"
kaggle_competencia_jr="labol-2025-ba-analista-jr"
kaggle_competencia_mgr="l-abo-i-2025-ba-gerencial"

export github_catedra_user="labo-imp"
export github_catedra_repo="labo2025ba"
export github_install_repo="cloudaustral"

export mlflow_usuario="labo2025ba"
export mlflow_clave="constructivism"



tabulador="	"
logfile="/home/$USER/install/log_install.txt"

MIHOST=$(echo $HOSTNAME | /usr/bin/cut -d . -f1)

bitacora () {
  local fecha=$(date +"%Y%m%d %H%M%S")

  echo "$fecha""$tabulador""$1"  >>  "$logfile"
}
