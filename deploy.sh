docker build -t rcomiskey/multi-client:latest -t rcomiskey/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rcomiskey/multi-server:latest -t rcomiskey/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rcomiskey/multi-worker:latest -t rcomiskey/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rcomiskey/multi-client:latest
docker push rcomiskey/multi-server:latest
docker push rcomiskey/multi-worker:latest

docker push rcomiskey/multi-client:$SHA
docker push rcomiskey/multi-server:$SHA
docker push rcomiskey/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rcomiskey/multi-server:$SHA
kubectl set image deployments/client-deployment client=rcomiskey/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rcomiskey/multi-worker:$SHA