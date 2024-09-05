docker-compose up --build -d

timeout /t 30 /nobreak > NUL

curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" http://localhost:8083/connectors/ --data "@sales-orders-connector.json"
curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" http://localhost:8083/connectors/ --data "@mongodb-sink-connector.json"

::timeout /t 15 /nobreak > NUL

::docker kill postgres_debezium_cdc-kafkacat
::docker run --tty --network postgres_debezium_cdc_default --name postgres_debezium_cdc-kafkacat confluentinc/cp-kafkacat kafkacat -b kafka:9092 -C -s key=s -s value=avro -r http://schema-registry:8081 -t sales_orders.public.orders
