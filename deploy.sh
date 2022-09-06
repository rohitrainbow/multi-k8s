docker build -t rohitrainbow/multi-client:latest -t rohitrainbow/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rohitrainbow/multi-server:latest -t rohitrainbow/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rohitrainbow/multi-worker:latest -t rohitrainbow/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rohitrainbow/multi-client:latest
docker push rohitrainbow/multi-server:latest
docker push rohitrainbow/multi-worker:latest

docker push rohitrainbow/multi-client:$SHA
docker push rohitrainbow/multi-server:$SHA
docker push rohitrainbow/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rohitrainbow/multi-server:$SHA
kubectl set image deployments/client-deployment client=rohitrainbow/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rohitrainbow/multi-worker:$SHA