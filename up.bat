@echo off

:: Subir os serviços com docker-compose
::docker-compose up --build -d
docker-compose up -d
if %errorlevel% neq 0 exit /b %errorlevel%

:: Esperar 30 segundos
timeout /t 30 /nobreak > NUL
if %errorlevel% neq 0 exit /b %errorlevel%

:: Registrar o conector "sales-orders-connector"
curl -X DELETE http://localhost:8083/connectors/sales-orders-connector
curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" http://localhost:8083/connectors/ --data "@sales-orders-connector.json"
if %errorlevel% neq 0 exit /b %errorlevel%

:: Registrar o conector "mongodb-sink-connector"
curl -X DELETE http://localhost:8083/connectors/mongodb-sink-connector
curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" http://localhost:8083/connectors/ --data "@mongodb-sink-connector.json"
if %errorlevel% neq 0 exit /b %errorlevel%

:: Comandos comentados - Descomente se necessário
:: timeout /t 15 /nobreak > NUL
:: if %errorlevel% neq 0 exit /b %errorlevel%

:: docker kill postgres_debezium_cdc-kafkacat
:: if %errorlevel% neq 0 exit /b %errorlevel%

:: docker run --tty --network postgres_debezium_cdc_default --name postgres_debezium_cdc-kafkacat confluentinc/cp-kafkacat kafkacat -b kafka:9092 -C -s key=s -s value=avro -r http://schema-registry:8081 -t sales_orders.public.orders
:: if %errorlevel% neq 0 exit /b %errorlevel%

@echo on
