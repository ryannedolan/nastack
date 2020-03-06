KIND_CLUSTER=nastack
KAFKA_IMG=wurstmeister/kafka:latest
ZOOKEEPER_IMG=wurstmeister/zookeeper:latest
FLINK_IMG=flink:latest

quick-start: kind-create-cluster kind-load-images

build-dir:
	-mkdir ./build

# create a Kubernetes-in-Docker cluster
kind-create-cluster: build-dir
	-kind create cluster --name ${KIND_CLUSTER} --config cluster/kind.yaml
	kind export kubeconfig --name ${KIND_CLUSTER}

build/.kubeconfig: kind-create-cluster
	kind export kubeconfig --name ${KIND_CLUSTER} --kubeconfig build/.kubeconfig

kind-delete-cluster:
	kind delete cluster --name ${KIND_CLUSTER}
	${RM} build/.kubeconfig

kind: build/.kubeconfig

pull-images:
	docker pull ${KAFKA_IMG}
	docker pull ${ZOOKEEPER_IMG}
	docker pull ${FLINK_IMG}

kind-load-images: pull-images
	kind load docker-image ${KAFKA_IMG}	--name ${KIND_CLUSTER}
	kind load docker-image ${ZOOKEEPER_IMG} --name ${KIND_CLUSTER}
	kind load docker-image ${FLINK_IMG} --name ${KIND_CLUSTER}

shell:
	kubectl exec -it nastack-shell -- /bin/bash

deploy-shell:
	kubectl create -f cluster/shell-pod.yaml

deploy-zookeeper:
	kubectl create -f cluster/zookeeper-deployment.yaml

deploy-kafka: deploy-zookeeper
	kubectl create -f cluster/kafka-deployment.yaml

deploy-flink:
	kubectl create -f cluster/flink-deployment.yaml

clean: kind-delete-cluster
	${RM} ./build/*
