cd C:\projects\vrl-neurobox-plugin\lib\ugInit-consolApp\.application
echo "Now in application dir:"
dir /s /b /o:gn


java -Xms128m -Xmx4096m -XX:MaxPermSize=256m -Djava.library.path="$LIBDIR:\home\travis\build\NeuroBox3D\VRL-NeuroBox-Plugin\lib\VRL-UG\VRL-UG\jars\apache-xmlrpc-3.1.3\lib\commons-logging-1.1.jar:\home\travis\build\NeuroBox3D\VRL-NeuroBox-Plugin\lib\VRL-UG\VRL-UG\jars\apache-xmlrpc-3.1.3\lib\ws-commons-util-1.0.2.jar:\home\travis\build\NeuroBox3D\VRL-NeuroBox-Plugin\lib\VRL-UG\VRL-UG\jars\apache-xmlrpc-3.1.3\lib\xmlrpc-client-3.1.3.jar:\home\travis\build\NeuroBox3D\VRL-NeuroBox-Plugin\lib\VRL-UG\VRL-UG\jars\apache-xmlrpc-3.1.3\lib\xmlrpc-common-3.1.3.jar:\home\travis\build\NeuroBox3D\VRL-NeuroBox-Plugin\lib\VRL-UG\VRL-UG\jars\apache-xmlrpc-3.1.3\lib\xmlrpc-server-3.1.3.jar"  -jar project.jar -property-folder property-folder\ -plugin-checksum-test no -install-plugin-help no -install-payload-plugins yes