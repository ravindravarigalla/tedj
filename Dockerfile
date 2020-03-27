FROM openjdk
VOLUME /tmp
EXPOSE 8080
RUN yum install -y procps
RUN yum whatprovides netstat
RUN yum -y install net-tools
RUN yum install -y unzip
COPY app.jar app.jar
ENTRYPOINT ["echo testing"]

