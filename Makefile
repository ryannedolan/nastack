
build:

deploy:
	kubectl apply -f cluster

bash: shell-ready
	kubectl exec -it nastack-shell -c nastack-shell -- /bin/bash

shell: shell-ready
	kubectl attach -it nastack-shell -c nastack-shell

shell-ready: deploy
	kubectl wait --for=condition=Ready pod/nastack-shell

clean:

uninstall:
	kubectl delete -f cluster
