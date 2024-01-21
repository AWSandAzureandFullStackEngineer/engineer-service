FROM openjdk:17.0.2-slim
ADD target/engineers-service-0.0.1-SNAPSHOT.jar engineers-service.jar
USER 65534
ENTRYPOINT ["java", "-jar", "engineers-service.jar"]


