FROM confluentinc/cp-kafka-connect-base:7.4.6

RUN confluent-hub install --no-prompt confluentinc/kafka-connect-avro-converter:7.7.0
RUN confluent-hub install --no-prompt mongodb/kafka-connect-mongodb:1.13.0
RUN confluent-hub install --no-prompt debezium/debezium-connector-postgresql:2.5.4