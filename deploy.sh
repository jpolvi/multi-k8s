docker build -t jhpo/multi-client:latest -t jhpo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jhpo/multi-server:latest -t jhpo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jhpo/multi-worker:latest -t jhpo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jhpo/multi-client:latest
docker push jhpo/multi-server:latest
docker push jhpo/multi-worker:latest

docker push jhpo/multi-client:$SHA
docker push jhpo/multi-server:$SHA
docker push jhpo/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=jhpo/multi-server:$SHA
kubectl set image deployments/client-deployment client=jhpo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jhpo/multi-worker:$SHA
