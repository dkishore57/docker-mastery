# Stage 1: Build the application
FROM maven:3.9.9-eclipse-temurin-21 AS build

# Copy the project
COPY . /app

# Change the working directory
WORKDIR /app

# Build the project
RUN mvn clean package

# Stage 2: Create a minimal runtime image
# alpine images are generally known for small sizes. 
FROM eclipse-temurin:21-jre-alpine 

# Copy the built jar from the first stage
COPY --from=build /app/target/dockermastery-0.0.1-SNAPSHOT.jar /app/dockermastery.jar

# Set the working directory
WORKDIR /app

# Expose application PORT
EXPOSE 8080

# Launch the jar
ENTRYPOINT ["java", "-jar", "dockermastery.jar"]
