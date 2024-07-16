package com.example.demo;
import org.apache.camel.builder.RouteBuilder;
import org.springframework.stereotype.Component;

@Component
public class TransformRoute extends RouteBuilder {

    @Override
    public void configure() throws Exception {
        from("kafka:input1?brokers=127.0.0.1:9092").to("atlasmap:atlasmap-mapping.adm").to("kafka:output?brokers=127.0.0.1:9092");      
    }
    
}
