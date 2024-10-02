# Use a imagem oficial do Maven para build
FROM maven:3.8.1-openjdk-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Use a imagem oficial do OpenJDK para rodar a aplicação
FROM openjdk:11-jre-slim
EXPOSE 8080
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
