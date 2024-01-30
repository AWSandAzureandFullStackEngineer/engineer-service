FROM openjdk:17.0.2-jdk-slim
COPY target/engineer-service-0.0.1-SNAPSHOT.jar /app/engineer-service.jar
USER 65534
CMD ["java", "-jar", "/app/engineers-service.jar"]





