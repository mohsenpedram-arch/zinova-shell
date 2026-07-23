spring:
  application:
    name: {{SERVICE_NAME}}

server:
  port: 8080

management:
  endpoints:
    web:
      exposure:
        include: health,metrics,prometheus,info
  metrics:
    tags:
      application: {{SERVICE_NAME}}
      environment: ${ARZIN_PROFILE:developer}
  otlp:
    tracing:
      endpoint: http://localhost:4318/v1/traces

otel:
  service:
    name: {{SERVICE_NAME}}
  exporter:
    otlp:
      endpoint: http://localhost:4318

logging:
  level:
    com.arzin: DEBUG
  pattern:
    console: "%d{yyyy-MM-dd HH:mm:ss} - %msg%n"
