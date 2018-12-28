docker build -t azsuth/multi-client:latest -t azsuth/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t azsuth/multi-server:latest -t azsuth/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t azsuth/multi-worker:latest -t azsuth/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push azsuth/multi-client:latest
docker push azsuth/multi-client:$SHA

docker push azsuth/multi-server:latest
docker push azsuth/multi-server:$SHA

docker push azsuth/multi-worker:latest
docker push azsuth/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=azsuth/multi-client:$SHA
kubectl set image deployments/server-deployment server=azsuth/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=azsuth/multi-worker:$SHA