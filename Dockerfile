cat Dockerfile
 FROM maven:3.6.3-jdk-21-openj9 AS builder

 WORKDIR usr/app

 COPY pom.xml .
 COPY src ./src

 RUN mvn package -DskipTests

 FROM adoptopenjdk/openjdk11:jre

 COPY --from=builder usr/app/target/spartan-app-new-nonsecure-0.0.1-SNAPSHOT.jar /spartan-app-new-nonsecure-0.0.1-SNAPSHOT.jar

 ENTRYPOINT ["java", "-jar", "spartan-app-new-nonsecure-0.0.1-SNAPSHOT.jar"]