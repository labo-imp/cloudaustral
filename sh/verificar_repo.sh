#!/bin/bash

source  /home/$USER/install/common.sh
source  /home/$USER/install/secrets.sh

if [ ! -d /home/$USER/$github_catedra_repo ]; then
    echo "Error Fatal : No existe la carpeta del repositorio /home/$USER/$github_catedra_repo"
    exit 1
fi

if [ ! -d /home/$USER/$github_catedra_repo/src ]; then
    echo "Error Fatal : No existe la carpeta  del repositorio  /home/$USER/$github_catedra_repo/src"
    exit 1
fi


if [ ! -d /home/$USER/$github_catedra_repo/src/rpart ]; then
    echo "Error Fatal : No existe la carpeta  del repositorio  /home/$USER/$github_catedra_repo/src/rpart"
    exit 1
fi

if [ ! -f /home/$USER/$github_catedra_repo/src/rpart/z101_PrimerModelo.R ]; then
    echo "Error Fatal : No existe el archivo  /home/$USER/$github_catedra_repo/src/rpart/z101_PrimerModelo.R"
    exit 1
fi


cd /home/$USER/$github_catedra_repo/

git rev-parse
if [ ! $? -eq 0 ]; then 
  echo "Error Fatal: git rev-parse fallo"
  exit 1
fi

git status
if [ ! $? -eq 0 ]; then 
  echo "Error Fatal: git status fallo"
  exit 1
fi

git branch --all
if [ ! $? -eq 0 ]; then 
  echo "Error Fatal: git branch -all  fallo"
  exit 1
fi

git rev-parse --verify   main
if [ ! $? -eq 0 ]; then 
  echo "Error Fatal: No existe branch  main"
  exit 1
fi

git rev-parse --verify   origin/main
if [ ! $? -eq 0 ]; then 
  echo "Error Fatal: No existe branch  origin/main"
  exit 1
fi

# git rev-parse --verify   instance-instalacion
# if [ ! $? -eq 0 ]; then 
#  echo "Error Fatal: No existe instance-instalacion"
#  exit
#fi


git ls-remote --exit-code --heads origin  main
if [ ! $? -eq 0 ]; then 
  echo "Error Fatal: No existe main en remote"
  exit 1
fi

git ls-remote --exit-code --heads origin  catedra
if [ ! $? -eq 0 ]; then 
  echo "Error Fatal: No existe catedra en remote"
  exit 1
fi

# git ls-remote --exit-code --heads origin  instance-instalacion
# if [ ! $? -eq 0 ]; then 
#  echo "Error Fatal: No existe instance-instalacion en remote"
#  exit
# fi


git fetch upstream
if [ ! $? -eq 0 ]; then 
  echo "Error Fatal: Fallo  git fetch upstream"
  exit 1
fi


source  /home/$USER/install/common.sh
source  /home/$USER/install/secrets.sh

if [ ! -f /home/$USER/cloud-install/r/"$kaggleprueba" ]; then
    echo "Error : No existe el archivo  /home/$USER/install/""$kaggleprueba"
    exit 1
fi

cp /home/$USER/cloud-install/r/"$kaggleprueba"  /home/$USER/$github_catedra_repo/src/rpart
if [ ! $? -eq 0 ]; then 
  echo "Error : No se pudo copiar /home/$USER/install/$kaggleprueba"
  exit 1
fi

cd /home/$USER/$github_catedra_repo/

MIHOST=$(echo $HOSTNAME | /usr/bin/cut -d . -f1)

git checkout catedra
if [ ! $? -eq 0 ]; then 
  echo "Fatal Error : git checkout catedra"
  exit 1
fi

git pull origin catedra
if [ ! $? -eq 0 ]; then 
  echo "Fatal Error : git pull origin catedra"
  exit 1
fi

git fetch upstream
if [ ! $? -eq 0 ]; then 
  echo "Fatal Error : git fetch upstream"
  exit 1
fi

git merge  -X theirs   upstream/main  -m "sync upstream/main to catedra"
if [ ! $? -eq 0 ]; then 
  echo "Fatal Error : git merge  -X theirs   upstream/main  -m 'sync upstream/main to catedra' "
  exit 1
fi

git push  origin  catedra
if [ ! $? -eq 0 ]; then 
  echo "Fatal Error : git push  origin  catedra "
  echo "Fatal Error : POSIBLEMENTE  su github token es INCORRECTO "
  exit 1
fi

#--------

git checkout main
if [ ! $? -eq 0 ]; then 
  echo "Fatal Error : git checkout main"
  exit 1
fi

git pull origin main
if [ ! $? -eq 0 ]; then 
  echo "Fatal Error : git pull origin main"
  exit 1
fi

git merge  -X theirs  catedra   -m "catedra domina a main"
if [ ! $? -eq 0 ]; then 
  echo "Fatal Error : git merge  -X theirs  catedra   -m 'catedra domina a main'"
  exit 1
fi

git push --set-upstream origin  main
if [ ! $? -eq 0 ]; then 
  echo "Fatal Error : git push --set-upstream origin  main"
  exit 1
fi

git checkout main
if [ ! $? -eq 0 ]; then 
  echo "Fatal Error : git checkout main"
  exit 1
fi


# activo el branch
git checkout $MIHOST
if [ ! $? -eq 0 ]; then 
  echo "Fatal Error : git checkout $MIHOST"
  exit 1
fi

git pull origin $MIHOST
if [ ! $? -eq 0 ]; then 
  echo "Fatal Error : git pull origin $MIHOST"
  exit 1
fi

git merge  -X theirs  catedra   -m "catedra domina  a MIHOST"
if [ ! $? -eq 0 ]; then 
  echo "Fatal Error : git merge  -X theirs  catedra   -m 'catedra domina  a MIHOST'"
  exit 1
fi

git merge  -X ours    main      -m "MIHOST domina  a main"
if [ ! $? -eq 0 ]; then 
  echo "Fatal Error : git merge  -X ours    main      -m 'MIHOST domina  a main'"
  exit 1
fi

git push  origin  $MIHOST
if [ ! $? -eq 0 ]; then 
  echo "Fatal Error : git push  origin  $MIHOST"
  exit 1
fi

git checkout main

git merge  -X theirs  $MIHOST   -m "MIHOST domina  a main"
if [ ! $? -eq 0 ]; then 
  echo "Fatal Error : git merge  -X theirs  $MIHOST   -m 'MIHOST domina  a main'"
  exit 1
fi

git push  origin  main
if [ ! $? -eq 0 ]; then 
  echo "Fatal Error : git push  origin  main"
  exit 1
fi


# cargo lo nuevo
git checkout $MIHOST
git add /home/$USER/$github_catedra_repo/src/rpart/"$kaggleprueba"
if [ ! $? -eq 0 ]; then 
  echo "Fatal Error : git add /home/$USER/$github_catedra_repo/src/rpart/$kaggleprueba"
  exit 1
fi

git commit -m "rpart/$kaggleprueba"


git push   origin  $MIHOST
git checkout main
git merge  -X theirs  $MIHOST   -m "MIHOST domina  a main"
if [ ! $? -eq 0 ]; then 
  echo "Fatal Error : git merge  -X theirs  $MIHOST   -m 'MIHOST domina  a main'"
  exit 1
fi

git push  origin  main
if [ ! $? -eq 0 ]; then 
  echo "Fatal Error : git push  origin  main"
  exit 1
fi

git checkout $MIHOST


echo
echo  repositorio OK

fecha=$(date +"%Y%m%d %H%M%S")
echo $fecha > /home/$USER/log/ins_verificar_repo.txt

exit 0