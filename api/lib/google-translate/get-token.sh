if [ $(uname -s) = "Darwin" ]; then
  GOOGLE_APPLICATION_CREDENTIALS=~/.secret/google-service-credential.json gcloud auth application-default print-access-token
else
  docker exec gcp /bin/bash ./get-token.sh
fi


