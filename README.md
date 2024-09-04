Para iniciar o conjunto de aplicações:

```
docker-compose up -d
```

Para registrar o conector do Debezium no banco PostgreSQL

```
curl -i -X POST =H "Accept:application/json" -H "Content-Type:application/json" 127.0.0.1:8083/connectors/ --data "@sales-orders-connector.json"
```

Para conectar no tópico do Kafka e visualizar as mensagens em tempo real:

```
docker run --tty --network postgres_debezium_cdc_default confluentinc/cp-kafkacat kafkacat -b kafka:9092 -C -s key=s -s value=avro -r http://schema-registry:8081 -t postgres.public.orders
```

Para terminar o conjunto de aplicações:

```
docker-compose down
```
