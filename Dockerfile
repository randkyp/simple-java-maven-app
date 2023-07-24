# Stage 1: Build the Maven project
FROM maven:3.9.0 AS builder
WORKDIR /app
RUN git clone https://github.com/randkyp/simple-java-maven-app.git
WORKDIR /app/simple-java-maven-app
RUN mvn -B -DskipTests clean package

# Stage 2: Deploy the resulting artifact
FROM openjdk:11-jre-slim
WORKDIR /deploy
COPY --from=builder /app/simple-java-maven-app/target/my-app-1.0-SNAPSHOT.jar app.jar

EXPOSE 8080
CMD ["java", "-cp", "app.jar", "com.mycompany.app.App"]
