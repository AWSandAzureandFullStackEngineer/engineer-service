FROM eclipse-temurin:17
ADD target/engineer-service-0.0.1-SNAPSHOT.jar ./app/engineer-service.jar
CMD ["java", "-jar", "./app/engineers-service.jar"]





