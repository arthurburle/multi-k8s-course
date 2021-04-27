docker build -t arthurburle/multi-client:latest -t arthurburle/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arthurburle/multi-server:latest -t arthurburle/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t arthurburle/multi-worker:latest -t arthurburle/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push arthurburle/multi-client:latest
docker push arthurburle/multi-server:latest
docker push arthurburle/multi-worker:latest

docker push arthurburle/multi-client:$SHA
docker push arthurburle/multi-server:$SHA
docker push arthurburle/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=arthurburle/multi-server:$SHA
kubectl set image deployments/client-deployment client=arthurburle/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=arthurburle/multi-worker:$SHA