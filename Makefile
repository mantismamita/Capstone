create-capstone-stack:
	cd cloudformation && sh create.sh capstone infra.yml params.json

update-capstone-stack:
	cd cloudformation && sh update.sh capstone infra.yml params.json

create-capstoneserver-stack:
	cd cloudformation && sh create.sh capstoneserverstack servers.yml servers.json

update-capstoneserver-stack:
	cd cloudformation && sh update.sh capstoneserverstack servers.yml servers.json && exit 0 && echo $?

update-stack:
	cd cloudformation && sh update.sh capstone infra.yml params.json && sh update.sh capstoneserverstack servers.yml servers.json && exit | echo "stack updated"

delete-stack: 
	cd cloudformation && sh delete.sh capstone && sh delete.sh capstoneserverstack && exit | echo "stack deleted"

docker-build: docker build --tag=capstone .