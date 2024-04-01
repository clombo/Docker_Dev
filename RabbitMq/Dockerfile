FROM rabbitmq:management

#Update packages lists and install curl
RUN apt-get update && apt-get install -y curl

#Copy configuration script that will create necessary queues and exchanges
COPY config.sh /usr/local/bin
RUN chmod +x /usr/local/bin/config.sh

#Run script and start server
CMD ["sh","-c","config.sh & rabbitmq-server"]