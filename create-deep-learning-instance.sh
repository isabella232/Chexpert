export PROJECT="jared-playground"
export IMAGE_FAMILY="pytorch-1-6-cu110"
export ZONE="us-west1-b"
export INSTANCE_NAME="deep-learning-instance"
export MACHINE_TYPE="n1-standard-4"

gcloud compute --project=$PROJECT instances create $INSTANCE_NAME \
  --machine-type=$MACHINE_TYPE \
  --zone=$ZONE \
  --scopes=https://www.googleapis.com/auth/cloud-platform \
  --tags=http-server,https-server \
  --image-family=$IMAGE_FAMILY \
  --image-project=deeplearning-platform-release \
  --maintenance-policy=TERMINATE \
  --accelerator="type=nvidia-tesla-v100,count=1" \
  --metadata="install-nvidia-driver=True" \
  --preemptible


gcloud compute --project=$PROJECT firewall-rules create default-allow-http \
   --direction=INGRESS \
   --priority=1000 \
   --network=default \
   --action=ALLOW \
   --rules=tcp:80 \
   --source-ranges=0.0.0.0/0 \
   --target-tags=http-server

gcloud compute --project=$PROJECT firewall-rules create default-allow-https \
  --direction=INGRESS \
  --priority=1000 \
  --network=default \
  --action=ALLOW \
  --rules=tcp:443 \
  --source-ranges=0.0.0.0/0 \
  --target-tags=https-server