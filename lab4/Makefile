# Krzysztof Kowalczyk kk385830 25.11.2018

all: users u1ssh server fssync

users:
	sudo ./create-users.sh

u1ssh:
	su u1 -s /bin/bash -c "./setup-students-ssh.sh"

server:
	sudo ./server-setup.sh

fssync:
	./students-fs.sh

clean:
	sudo ./clean-users.sh
	-sudo ./clean-server.sh
	-./clean-students-fs.sh
