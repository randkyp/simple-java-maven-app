# Use a base image with Java installed
FROM openjdk:11-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file into the container
COPY docker/app.jar .

# Expose the port the web server is listening on
EXPOSE 8080

# Set the entry point to run the Java application
ENTRYPOINT ["java", "-jar", "app.jar"]
