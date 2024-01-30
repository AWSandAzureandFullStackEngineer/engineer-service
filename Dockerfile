FROM openjdk:20
ADD target/engineer-service-0.0.1-SNAPSHOT.jar engineer-service.jar
USER 65534
ENTRYPOINT ["java", "-jar", "engineers-service.jar"] CMD ["-start"]





