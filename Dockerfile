# Standalone container for SIGEVH, run with:
#   docker build -t sigevh-webapp .
#   docker run -d --name sigevh-webapp --network cesardl-bridge-network -p 8443:8443 sigevh-webapp
#
# Reuses the project's own documented run command (tomcat7-maven-plugin embedded
# Tomcat, HTTPS on 8443, context /SIGEVH) instead of hand-rolling a separate
# standalone-Tomcat deployment.
FROM maven:3.9-eclipse-temurin-21

WORKDIR /app
COPY . .

# This container reaches the database over the Docker network by container
# name, not localhost — point this build's hibernate.cfg.xml at the "mysql-v8"
# container instead of the localhost:3306 used for local (non-containerized)
# dev/test. The checked-in hibernate.cfg.xml is left untouched for everyone
# running Maven directly against mysql-ice-creams-providers on localhost.
RUN sed -i 's#localhost:3306#mysql-v8:3306#' src/main/resources/hibernate.cfg.xml

RUN mvn -q -B clean compile -DskipTests

EXPOSE 8443

CMD ["mvn", "-B", "org.apache.tomcat.maven:tomcat7-maven-plugin:run"]
