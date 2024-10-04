# COMPOSE
# BASE IMAGE
FROM maven:3.9.8-eclipse-temurin-17 AS build
WORKDIR /opt/app
COPY . /opt/app
RUN mvn clean package -DskipTests

# BASE IMAGE
FROM eclipse-temurin:17-jre-alpine

# CONFIGURE FINAL IMAGE
WORKDIR /opt/app
COPY --from=build /opt/app/target/app.jar /opt/app/app.jar

# ENVIRONMENT VARIABLES
ENV PROFILE=prd

# PORT
EXPOSE 8080

# INIT
ENTRYPOINT ["sh", "-c", "java -Dspring.profiles.active=$PROFILE -jar /opt/app/app.jar"]




# # Use a imagem oficial do Maven para build
# FROM maven:3.8.1-openjdk-11 AS build
# WORKDIR /app
# COPY pom.xml .
# COPY src ./src
# RUN mvn clean package -DskipTests
#
# # Use a imagem oficial do OpenJDK para rodar a aplicação
# FROM openjdk:11-jre-slim
# EXPOSE 8080
# COPY --from=build /app/target/*.jar app.jar
# ENTRYPOINT ["java","-jar","/app.jar"]
