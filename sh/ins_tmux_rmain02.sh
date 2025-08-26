#!/bin/bash

myfirstproject=$(gcloud projects list  --format='value(PROJECT_ID)' | head -1 )
gcloud config set project $myfirstproject

gcloud compute ssh "$USER"@instance-instalacion \
    --zone=us-west4-c \
    --project="$myfirstproject" \
    -- bash -s < /home/$USER/cloud-install/sh/ins_tmux_main02.sh
