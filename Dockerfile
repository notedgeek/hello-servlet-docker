FROM maven:3.6.0-jdk-8 as maven
COPY ./pom.xml ./pom.xml
RUN mvn dependency:go-offline -B

COPY ./src ./src
COPY ./web ./web
RUN mvn package -DskipTests

FROM tomcat:8.5.57-jdk8-corretto
WORKDIR /my-project
COPY --from=maven target/web-app-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/web-app.war
EXPOSE 8080
CMD ["catalina.sh","run"]

