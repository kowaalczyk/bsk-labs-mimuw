all: assignment1 assignment2 assignment3 assignment4

assignment1:
	# create a new CA
	openssl genrsa -des3 -out keys/CA.key 2048  # create RSA key pair for CA
	openssl req -x509 -new -nodes -key keys/CA.key -sha256 -days 3650 -out keys/CA.pem
	
assignment2:
	openssl genrsa -out keys/bsk830.mimuw.edu.pl.key 2048  # generate RSA private key for the host
	openssl req -new -key keys/bsk830.mimuw.edu.pl.key -out keys/bsk830.mimuw.edu.pl.csr  # request certificate for the host

assignment3:
	openssl x509 -req -in keys/bsk830.mimuw.edu.pl.csr -CA keys/CA.pem -CAkey keys/CA.key -CAcreateserial -out keys/bsk830.mimuw.edu.pl.crt -days 1460 -sha256  # generate certificate for the host

assignment4:
	docker build -t bsk-nginx .
	docker run --name bsk-nginx -p 443:443 --rm bsk-nginx
	echo "Make sure port 333 is forwarded from VM to host machine"
	echo "Add following line to /etc/hosts:"
	echo "127.0.0.1	bsk830.mimuw.edu.pl"

clean:
	-rm keys/*
	-docker kill bsk-nginx
	-docker container rm bsk-nginx
