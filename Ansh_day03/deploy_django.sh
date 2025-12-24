#!/bin/bash


<< task
Deploy a Django app
and handle the code for errors
task

code_clone(){
 
	echo "Cloning the django app...."
	git clone https://github.com/LondheShubham153/django-notes-app.git

}

install_requirements(){
        echo "Installing dependencies"
	sudo apt-get install docker.io nginx -y docker-compose
}
i
required_restarts(){
       sudo chown $USER /var/run/docker.sock
       #sudo systemctl enable docker
       #sudo systemcl enable nginx
       #sudo systemctl restart docker
}

deploy() {
       docker build  -t notes-app .
       #docker run -d -p 8000:8000 notes-app:latest
       docker-compose up -d
}

echo "*********** DEPLOYMENT STARTED ************"

if ! code_clone; then
	echo "THE CODE ALREADY EXISTS"
	cd django-notes-app
fi

if ! install_requirements; then 
	echo "INSTALLATION FAILED"
	exit 1
fi

if ! required_restarts; then
	echo "System fault identified"
	exit 1
fi

if ! deploy; then
	echo "DEPLOYMENT FAILED, MAILING THE ADMIN"
	# sendmail
	exit 1
fi
code_clone
install_requirements
required_restarts
deploy

echo "*********** DEPLOYMENT DONE ***************"
