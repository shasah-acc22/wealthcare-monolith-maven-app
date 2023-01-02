FROM openliberty/open-liberty:kernel-java8-openj9-ubi
WORKDIR /tmp

COPY wcareEar/target/wcare.ear /opt/ol/wlp/usr/servers/defaultServer/apps/wcare.ear
COPY config/server.xml /opt/ol/wlp/usr/servers/defaultServer/
EXPOSE 9080
#ENTRYPOINT ["java","-jar","/app.jar"]
