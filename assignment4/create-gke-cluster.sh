#!/bin/bash -x

if (( $# < 2 )); then
    echo "./create-gke-cluster.sh <project-id> <cluster-name>"
    exit 0
fi

project=$1
clusterName=$2

gcloud beta container --project "$project" clusters create "$clusterName" --zone "us-central1-b" --no-enable-basic-auth --cluster-version "1.31.8-gke.1113000" --release-channel "regular" --machine-type "e2-standard-2" --disk-type "pd-standard" --disk-size "100" --metadata disable-legacy-endpoints=true --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --num-nodes "1" --enable-stackdriver-kubernetes --enable-ip-alias --network "projects/$project/global/networks/default" --subnetwork "projects/$project/regions/us-central1/subnetworks/default" --default-max-pods-per-node "110" --no-enable-master-authorized-networks --addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver --enable-autoupgrade --enable-autorepair --max-surge-upgrade 1 --max-unavailable-upgrade 0 --enable-shielded-nodes --node-locations "us-central1-b"
