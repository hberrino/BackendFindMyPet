FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

COPY --from=build /app/target/find-0.0.1-SNAPSHOT.jar app.jar

RUN mkdir -p /app/uploads

EXPOSE 8080

ENV SPRING_PROFILES_ACTIVE=prod
ENV DB_URL=jdbc:mysql://mysql:3306/tumascotandil?createDatabaseIfNotExist=true&useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
ENV DB_USERNAME=root
ENV DB_PASSWORD=Hernan007.

ENTRYPOINT ["java", "-jar", "app.jar"]
