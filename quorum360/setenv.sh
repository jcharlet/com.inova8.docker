export CATALINA_OPTS="$CATALINA_OPTS -Xms4096m -Xmx4096m"
export CLASSPATH="$CLASSPATH:$CATALINA_HOME/lib/servlet-api.jar:"`/opt/hbase/bin/hbase classpath`