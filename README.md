Para iniciar o conjunto de aplicações:

```
docker-compose up -d
```

Para registrar o conector do Debezium no banco PostgreSQL

```
curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" 127.0.0.1:8083/connectors/ --data "@sales-orders-connector.json"
```

Para conectar no tópico do Kafka e visualizar as mensagens em tempo real:

```
docker run --tty --network postgres_debezium_cdc_default --name postgres_debezium_cdc-kafkacat confluentinc/cp-kafkacat kafkacat -b kafka:9092 -C -s key=s -s value=avro -r http://schema-registry:8081 -t postgres-server.public.orders
```

Debezium UI:

```
docker run -it --network postgres_debezium_cdc_default --rm --name debezium-ui -p 8080:8080 -e KAFKA_CONNECT_URIS=http://debezium:8083 debezium/debezium-ui:1.9
```


Para terminar o conjunto de aplicações:

```
docker-compose down
```
