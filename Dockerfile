FROM openjdk:17
ADD target/engineers-service-0.0.1-SNAPSHOT.jar engineers-service.jar
ENTRYPOINT ["java", "-jar", "engineers-service.jar"]