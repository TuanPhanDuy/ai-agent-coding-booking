FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY xxxx-start/target/xxxx-start-1.0-SNAPSHOT.jar app.jar
EXPOSE 1122
ENTRYPOINT ["java", "-jar", "app.jar"]
