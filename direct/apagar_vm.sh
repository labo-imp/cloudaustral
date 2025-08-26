#!/bin/bash

MIHOST=$(echo $HOSTNAME | /usr/bin/cut -d . -f1)

if [[ $MIHOST == desktop* || $MIHOST == "instance-instalacion" ]]; then
  /home/$USER/install/zulip_enviar.sh  "SHUTDOWN SOFT    $HOSTNAME"
  nombrevm=$(curl -X GET http://metadata.google.internal/computeMetadata/v1/instance/name -H 'Metadata-Flavor: Google')
  zonavm=$(curl -X GET http://metadata.google.internal/computeMetadata/v1/instance/zone -H 'Metadata-Flavor: Google')
  gcloud --quiet compute instances stop $nombrevm --zone=$zonavm
else
  /home/$USER/install/zulip_enviar.sh  "SHUTDOWN EVAPORATE    $HOSTNAME"
  nombrevm=$(curl -X GET http://metadata.google.internal/computeMetadata/v1/instance/name -H 'Metadata-Flavor: Google')
  zonavm=$(curl -X GET http://metadata.google.internal/computeMetadata/v1/instance/zone -H 'Metadata-Flavor: Google')
  gcloud --quiet compute instances delete $nombrevm --zone=$zonavm
fi
