# Build based on Tomcat
FROM tomcat:9-jre8
LABEL odata2northwind:latest inova8/odata2northwind:latest
LABEL version="1.0"
LABEL maintainer = "peter.lawrence@inova8.com"
LABEL description = "RDF4J and OData2SPARQL hosted in Tomcat v9 for the purpose of testing OData2SPARQL.V4 against an example database (northwind)"

# Setup variables
ARG RDF4J_VERSION="2.4.4" 
ENV RDF4J_DATA="/opt/eclipse-rdf4j-${RDF4J_VERSION}/data" 
ARG JVM_PARAMS="-Xmx4g" 
ENV ODATA4SPARQL ="C:/Users/Peter/git/com.inova8.odata2sparql.v4/odata2sparql.v4/target/"
ENV SERVER ="C:/Users/Peter/AppData/Roaming/rdf4j/data/server"
ENV MODELS="/var/opt/inova8/odata2sparql/V4" 

# Install the lastest RDF4J server and workbench
RUN curl -sS -o /tmp/rdf4j.zip -L http://download.eclipse.org/rdf4j/eclipse-rdf4j-${RDF4J_VERSION}-sdk.zip && \
    cd /opt && \ 
    unzip /tmp/rdf4j.zip && \
    rm /tmp/rdf4j.zip
RUN mv /opt/eclipse-rdf4j-${RDF4J_VERSION}/war/*.war /usr/local/tomcat/webapps
RUN echo "CATALINA_OPTS=\"\$CATALINA_OPTS \$JVM_PARAMS -Dorg.eclipse.rdf4j.appdata.basedir=\$RDF4J_DATA\"" >> /usr/local/tomcat/bin/setenv.sh

# Configure Tomcat users
ADD  tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
ADD  context.xml  /usr/local/tomcat/webapps/manager/META-INF/context.xml

# Install odata2sparql and its configuration file (models.ttl)
ADD  odata2sparql.v4.war  /usr/local/tomcat/webapps/odata2sparql.war
ADD  models.ttl /var/opt/inova8/odata2sparql/V4/

# Copy model files for consistency and rebuilding if required.
ADD  server ${RDF4J_DATA}/server

# Publish RDF4J data volumes
VOLUME ${RDF4J_DATA}
VOLUME ${MODELS}
EXPOSE 8080

