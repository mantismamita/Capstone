create-capstoneInfra-stack:
	sh cloudformation/create.sh capstoneInfra cloudformation/infra.yml cloudformation/params.json

update-capstoneInfra-stack:
	sh cloudformation/update.sh capstoneInfra infra.yml params.json

create-capstoneJenkins-stack:
	sh cloudformation/create.sh capstoneJenkins cloudformation/jenkins.yml cloudformation/jenkinsParams.json

update-capstoneJenkins-stack:
	sh cloudformation/update.sh capstoneJenkins cloudformation/jenkins.yml cloudformation/jenkinsparams.json

update-stack:
	sh cloudformation/update.sh capstone infra.yml params.json && sh update.sh capstoneserverstack servers.yml servers.json && exit | echo "stack updated"

delete-stack: 
	sh cloudformation/delete.sh capstone && sh delete.sh capstoneserverstack && exit | echo "stack deleted"

docker-build: docker build --tag=capstone .