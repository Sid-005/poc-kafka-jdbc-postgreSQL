# poc-kafka-jdbc-postgreSQL
 A POC that connects Apache kafka with postgreSQL using the JDBC connector

 ## Using Docker to start and stop the services
 1) Starting docker containers= docker-compose -f compose.yml -f postgres.yml -f kafka.yml up
 2) Stopping docker containers = docker stop connect kafka zookeeper postgres
 3) Removing docker containers = docker rm zookeeper kafka postgres connect

 ## Manipulating existing connectors
 1) Checking running connectors: curl -X GET http://localhost:8083/connectors
 2) Deleting a connector: curl --location --request DELETE 'http://localhost:8083/connectors/<connector_name>'
 3) Pausing a connector: curl -X PUT http://localhost:8083/connectors/<connector-name>/pause

 ## Template Source Connector
 curl --location --request POST 'http://localhost:8083/connectors' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "jdbc-source-1",
    "config": {
        "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
        "connection.url": "jdbc:postgresql://postgres:5432/postgres",
        "connection.user": "postgres",
        "connection.password": "postgres",
        "topic.prefix": "input1",
        "mode": "bulk",
        "query": "SELECT id,name,status FROM public.invoices where status='\''R'\'';",
        "poll.interval.ms": 5000,
        "value.converter": "org.apache.kafka.connect.json.JsonConverter",
        "value.converter.schemas.enable": "true"
    }
}'

## Template Sink connector
curl --location --request POST 'http://localhost:8083/connectors' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "jdbc-sink-1",
    "config": {
        "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
        "connection.url": "jdbc:postgresql://postgres:5432/postgres",
        "connection.user": "postgres",
        "connection.password": "postgres",
        "table.name.format": "invoices",
        "topics": "output",
        "insert.mode": "upsert",
        "pk.mode": "record_value",
        "pk.fields": "id",
        "poll.interval.ms": 5000,
        "value.converter": "org.apache.kafka.connect.json.JsonConverter",
        "value.converter.schemas.enable": "true",
        "auto.create": "true"
    }
}'

