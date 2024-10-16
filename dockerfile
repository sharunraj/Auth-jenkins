FROM openjdk:21-oracle
COPY ./target/SpringSecurity-0.0.1-SNAPSHOT.jar springsecurity.jar

CMD ["java","-jar","springsecurity.jar"]
