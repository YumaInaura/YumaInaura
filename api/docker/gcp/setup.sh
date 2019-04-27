
# hey Let's create docker-compose.yml

cp ~/.secret/google-service-credential.json ./

docker build . -t gcp

docker run -d --name=gcp gcp sleep infinity

