#!/bin/bash

# Wait for RabbitMQ to start
sleep 10

# Configure RabbitMQ (Replace values as per your requirements)
curl -i -u guest:guest -XPUT http://localhost:15672/api/exchanges/%2F/TestExchange -H "content-type:application/json" -d'{"type":"fanout"}'
curl -i -u guest:guest -XPUT http://localhost:15672/api/queues/%2F/newpayment-queue -H "content-type:application/json" -d'{"auto_delete":false,"durable":true}'
curl -i -u guest:guest -XPOST http://localhost:15672/api/bindings/%2F/e/TestExchange/q/newpayment-queue -H "content-type:application/json"
