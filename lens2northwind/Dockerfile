# Build based on Tomcat
FROM tomcat:9.0.7
MAINTAINER Peter Lawrence "peter.lawrence@inova8.com"

# Setup variables
ENV RDF4J_VERSION="2.3.2" 
ENV RDF4J_DATA="/opt/eclipse-rdf4j-${RDF4J_VERSION}/data" 
ENV JVM_PARAMS="-Xmx4g" 
ENV ODATA4SPARQL ="C:/Users/Peter/git/com.inova8.odata2sparql.v4/odata2sparql.v4/target/"
ENV FRAMEWORK ="C:/Apps/SAPWebIDE/serverworkspace/pe/peterlawrence1/OrionContent/com.inova8.lens.framework.v4/target/"
ENV SERVER ="C:/Users/Peter/AppData/Roaming/rdf4j/data/server"

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

# Install lens framwork and its preprared repositories 
# NOTE that since the odata4sparql is now on a different server than the app is running,  it should be redirected in the <apartment>/manifest.json.
# For example "sap.app": {	"dataSources": {"dataService": "uri": "http://localhost:8080/odata2sparql/northwind/" -> "http://localhost:<Port of Docker container>/odata2sparql/northwind/"
ADD  com.inova8.lens.framework.v4.war  /usr/local/tomcat/webapps/lens2odata.war 
ADD  server $RDF4J_DATA/server

# Copy model files for consistency and rebuilding if required.
#ADD  inova8.northwind /var/opt/inova8/odata2sparql/northwind/
#ADD  NHS /var/opt/inova8/odata2sparql/NHS/

# Publish RDF4J data volumes
VOLUME ${RDF4J_DATA}
EXPOSE 8080

