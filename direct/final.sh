source  /home/$USER/install/common.sh

printf  "\n\nCreando la imagen del sistema operativo, esto va a demorar 6 minutos.\n"
printf  "Le va a parecer que no se esta haciendo nada, pero ESPERE esos 6 minutos ! \nNo se impaciente ! \n\n"

MIHOST=$(echo $HOSTNAME | cut -d . -f1)
MIZONA=$(gcloud compute instances list --filter=$MIHOST --format='value(ZONE)')

printf "\n borrando imagen image-dm vieja en caso que hubiera quedado como resabio de intento de instalacion anterior\n\n"
gcloud compute images delete image-dm  --quiet  --verbosity=none

gcloud compute images create image-dm   \
       --source-disk=$MIHOST            \
       --source-disk-zone=$MIZONA       \
       --storage-location=us            \
       --force

bitacora   "vm image"

printf  '\nun gran paso : imagen creada.\n\n'

#------------------------------------------------------------------------------


SEAC=$(gcloud iam service-accounts list --filter=Compute --format='value(EMAIL)')
echo $SEAC


# 8vcpu  32 GB RAM
gcloud beta compute instance-templates delete temp-08vcpu-032ram  --region=northamerica-northeast2 --quiet  --verbosity=none

gcloud beta compute instance-templates create temp-08vcpu-032ram         \
       --machine-type=custom-8-32768-ext                            \
       --network-interface=network=default,network-tier=PREMIUM     \
       --no-restart-on-failure --maintenance-policy=TERMINATE       \
       --provisioning-model=SPOT                                    \
       --instance-termination-action=DELETE                         \
       --service-account=$SEAC                                      \
       --scopes=cloud-platform                                      \
       --tags=http-server,https-server                              \
       --instance-template-region=northamerica-northeast2           \
       --create-disk=auto-delete=yes,boot=yes,device-name=temp-08vcpu-032ram,image=image-dm,mode=rw,size=256,type=pd-standard \
       --no-shielded-secure-boot --shielded-vtpm                    \
       --shielded-integrity-monitoring --reservation-affinity=any   \
       --metadata-from-file shutdown-script=/home/$USER/cloud-install/direct/shutdown-script.sh


# 8vcpu  64 GB RAM
gcloud compute instance-templates delete temp-08vcpu-064ram  --region=northamerica-northeast2 --quiet  --verbosity=none

gcloud compute instance-templates create temp-08vcpu-064ram         \
       --machine-type=custom-8-65536-ext                            \
       --network-interface=network=default,network-tier=PREMIUM     \
       --no-restart-on-failure --maintenance-policy=TERMINATE       \
       --provisioning-model=SPOT                                    \
       --instance-termination-action=DELETE                         \
       --service-account=$SEAC                                      \
       --scopes=cloud-platform                                      \
       --tags=http-server,https-server                              \
       --instance-template-region=northamerica-northeast2           \
       --create-disk=auto-delete=yes,boot=yes,device-name=temp-08vcpu-064ram,image=image-dm,mode=rw,size=256,type=pd-standard \
       --no-shielded-secure-boot --shielded-vtpm                    \
       --shielded-integrity-monitoring --reservation-affinity=any   \
       --metadata-from-file shutdown-script=/home/$USER/cloud-install/direct/shutdown-script.sh


# 8vcpu  128 GB RAM
gcloud compute instance-templates delete temp-08vcpu-128ram  --region=northamerica-northeast2 --quiet  --verbosity=none

gcloud compute instance-templates create temp-08vcpu-128ram         \
       --machine-type=custom-8-131072-ext                           \
       --network-interface=network=default,network-tier=PREMIUM     \
       --no-restart-on-failure --maintenance-policy=TERMINATE       \
       --provisioning-model=SPOT                                    \
       --instance-termination-action=DELETE                         \
       --service-account=$SEAC                                      \
       --scopes=cloud-platform                                      \
       --tags=http-server,https-server                              \
       --instance-template-region=northamerica-northeast2           \
       --create-disk=auto-delete=yes,boot=yes,device-name=temp-08vcpu-128ram,image=image-dm,mode=rw,size=256,type=pd-standard \
       --no-shielded-secure-boot --shielded-vtpm                    \
       --shielded-integrity-monitoring --reservation-affinity=any   \
       --metadata-from-file shutdown-script=/home/$USER/cloud-install/direct/shutdown-script.sh



# 8vcpu  256 GB RAM
gcloud compute instance-templates delete temp-08vcpu-256ram  --region=northamerica-northeast2 --quiet  --verbosity=none

gcloud compute instance-templates create temp-08vcpu-256ram         \
       --machine-type=custom-8-262144-ext                           \
       --network-interface=network=default,network-tier=PREMIUM     \
       --no-restart-on-failure --maintenance-policy=TERMINATE       \
       --provisioning-model=SPOT                                    \
       --instance-termination-action=DELETE                         \
       --service-account=$SEAC                                      \
       --scopes=cloud-platform                                      \
       --tags=http-server,https-server                              \
       --instance-template-region=northamerica-northeast2           \
       --create-disk=auto-delete=yes,boot=yes,device-name=temp-08vcpu-256ram,image=image-dm,mode=rw,size=256,type=pd-standard \
       --no-shielded-secure-boot --shielded-vtpm                    \
       --shielded-integrity-monitoring --reservation-affinity=any   \
       --metadata-from-file shutdown-script=/home/$USER/cloud-install/direct/shutdown-script.sh


# 8vcpu  512 GB RAM
gcloud compute instance-templates delete temp-08vcpu-512ram  --region=northamerica-northeast2 --quiet  --verbosity=none

gcloud compute instance-templates create temp-08vcpu-512ram         \
       --machine-type=custom-8-524288-ext                           \
       --network-interface=network=default,network-tier=PREMIUM     \
       --no-restart-on-failure --maintenance-policy=TERMINATE       \
       --provisioning-model=SPOT                                    \
       --instance-termination-action=DELETE                         \
       --service-account=$SEAC                                      \
       --scopes=cloud-platform                                      \
       --tags=http-server,https-server                              \
       --instance-template-region=northamerica-northeast2           \
       --create-disk=auto-delete=yes,boot=yes,device-name=temp-08vcpu-512ram,image=image-dm,mode=rw,size=256,type=pd-standard \
       --no-shielded-secure-boot --shielded-vtpm                    \
       --shielded-integrity-monitoring --reservation-affinity=any   \
       --metadata-from-file shutdown-script=/home/$USER/cloud-install/direct/shutdown-script.sh

bitacora   "vm templates"

#------------------------------------------------------------------------------

source  /home/$USER/install/common.sh

SEAC=$(gcloud iam service-accounts list --filter=Compute --format='value(EMAIL)')
echo $SEAC


# borro desktop por si quedo de alguna instalacion anterior
gcloud compute instances  delete  desktop-jr   --zone=southamerica-east1-c \
       --quiet  --verbosity=none

printf  '\n\n\nIniciando creacion de virtual machine desktop-jr\n\n'

# creo la virtual machine desktop
gcloud compute instances create desktop-jr \
    --zone=southamerica-east1-c \
    --machine-type=e2-highmem-8  \
    --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \
    --no-restart-on-failure \
    --maintenance-policy=MIGRATE \
    --provisioning-model=STANDARD  \
    --service-account=$SEAC \
    --scopes=https://www.googleapis.com/auth/cloud-platform \
    --tags=http-server,https-server \
    --create-disk=auto-delete=yes,boot=yes,device-name=desktop-jr,image=image-dm,mode=rw,size=192,type=pd-standard \
    --no-shielded-secure-boot  \
    --metadata-from-file shutdown-script=/home/$USER/cloud-install/direct/shutdown-script.sh

printf  '\nvirtual machine  desktop-jr  CREADA\n\n'

printf  '\nesperando 2 minutos para apagar desktop-jr\n\n'
sleep 120

# la detengo
gcloud compute instances  stop  desktop-jr   --zone=southamerica-east1-c

source  /home/$USER/install/common.sh

bitacora   "desktop-jr creation"

#------------------------------------------------------------------------------

source  /home/$USER/install/common.sh

# creo desktop-sr
gcloud compute instances create desktop-sr \
    --zone=southamerica-east1-c \
    --machine-type=e2-standard-4 \
    --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \
    --no-restart-on-failure \
    --maintenance-policy=TERMINATE \
    --provisioning-model=SPOT \
    --instance-termination-action=STOP \
    --service-account=$SEAC \
    --scopes=https://www.googleapis.com/auth/cloud-platform \
    --tags=http-server,https-server \
    --create-disk=auto-delete=yes,boot=yes,device-name=desktop-sr,image=image-dm,mode=rw,size=64,type=pd-standard \
    --no-shielded-secure-boot  \
    --metadata-from-file shutdown-script=/home/$USER/cloud-install/direct/shutdown-script.sh


printf  '\nvirtual machine  desktop-sr  CREADA\n\n'

printf  '\nesperando 2 minutos para apagar desktop-sr\n\n'
sleep 120

# la detengo
gcloud compute instances  stop  desktop-sr   --zone=southamerica-east1-c

source  /home/$USER/install/common.sh

bitacora   "desktop-sr creation"


#------------------------------------------------------------------------------
printf  '\n\n\n\n'
read -r -p "Presione la tecla Enter para finalizar..." key

bitacora   "END  final.sh"

/home/$USER/cloud-install/direct/apagar_vm.sh
