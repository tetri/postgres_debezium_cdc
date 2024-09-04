docker-compose up -d

timeout /t 15 /nobreak > NUL

curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" 127.0.0.1:8083/connectors/ --data "@sales-orders-connector.json"

timeout /t 15 /nobreak > NUL

docker kill postgres_debezium_cdc-kafkacat
docker run --tty --network postgres_debezium_cdc_default --name postgres_debezium_cdc-kafkacat confluentinc/cp-kafkacat kafkacat -b kafka:9092 -C -s key=s -s value=avro -r http://schema-registry:8081 -t postgres-server.public.orders
