# Standalone container for SIGEVH, run with:
#   docker build -t sigevh-webapp .
#   docker run -d --name sigevh-webapp --network cesardl-bridge-network -p 8443:8443 sigevh-webapp
#
# Uses a real Tomcat 9 distribution (tomcat7-maven-plugin was retired: it only
# existed to give local dev a Tomcat instance before Docker was the norm, and
# its bundled Jasper can't compile JSPs under JDK 9+'s classloader changes).
# Tomcat 9 is the newest line that still speaks javax.servlet/javax.faces,
# which this JSF 1.2 app requires — Tomcat 10+ moved to jakarta.servlet.
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /app
COPY . .

# This container reaches the database over the Docker network by container
# name, not localhost — point this build's hibernate.cfg.xml at the "mysql-v8"
# container instead of the localhost:3306 used for local (non-containerized)
# dev/test. The checked-in hibernate.cfg.xml is left untouched for everyone
# running Maven directly against mysql-ice-creams-providers on localhost.
RUN sed -i 's#localhost:3306#mysql-v8:3306#' src/main/resources/hibernate.cfg.xml

RUN mvn -q -B clean package -DskipTests

FROM tomcat:9.0-jdk21-temurin

RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/sigevh-webapp-1.0.0-SNAPSHOT.war /usr/local/tomcat/webapps/SIGEVH.war
COPY tomcat/server.xml /usr/local/tomcat/conf/server.xml
COPY tomcat/conf/logging.properties /usr/local/tomcat/conf/logging.properties
COPY tomcat/keystore/ice-creams-providers.p12 /usr/local/tomcat/conf/ice-creams-providers.p12

EXPOSE 8443
