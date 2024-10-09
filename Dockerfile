# Use Maven to build the application
FROM maven:3.8.4-openjdk-11 AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml ./
COPY src ./src
RUN mvn clean package -DskipTests

# Use a lightweight JRE image to run the application
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/spring-boot-rest1-0.0.1-SNAPSHOT.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
