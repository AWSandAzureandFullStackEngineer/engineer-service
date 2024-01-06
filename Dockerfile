FROM eclipse-temurin:17-jre-alpine
ADD target/engineers-service-0.0.1-SNAPSHOT.jar engineers-service.jar
USER 65534
ENTRYPOINT ["java", "-jar", "engineers-service.jar"]