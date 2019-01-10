all: dhparam.pem

dhparam.pem:
	openssl dhparam -out $@ 2048

.PHONY: clean
clean: tls-clean
	-rm -f dhparam.pem
