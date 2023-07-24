# Stage 1: Build the Maven project
FROM maven:3.9.0 AS builder
WORKDIR /app
RUN git clone https://github.com/randkyp/simple-java-maven-app.git
WORKDIR /app/simple-java-maven-app
RUN mvn -B -DskipTests clean package

# Stage 2: Deploy the resulting artifact
FROM openjdk:11-jre-slim
WORKDIR /deploy
COPY --from=builder /app/project_url/target/*.jar app.jar

EXPOSE 8080
# Set the startup command to run the .jar file
CMD ["java", "-jar", "app.jar"]