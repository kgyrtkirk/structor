#!/bin/sh

HOST=$(hostname)
BASE_PATH=/etc
KEYSTORE_PATH=$BASE_PATH/keystore.jks
CERTIFICATE_PATH=$BASE_PATH/${HOST}.crt
TRUSTSTORE_PATH=$BASE_PATH/truststore.jks
TRUSTSTORE_PASS=fedcba
KEY_PASS=abcdef
cd /tmp
echo $HOST > key_info.txt
cat>>key_info.txt<<EOF
Self
Self
San Jose
CA
US
yes
EOF
rm -f $KEYSTORE_PATH $CERTIFICATE_PATH $TRUSTSTORE_PATH
keytool -genkey -alias $HOST -keyalg RSA -keystore $KEYSTORE_PATH -keysize 2048 -deststorepass $KEY_PASS -destkeypass $KEY_PASS < key_info.txt
keytool -list -keystore $KEYSTORE_PATH -deststorepass $KEY_PASS
keytool -export -alias $HOST -file $CERTIFICATE_PATH -keystore $KEYSTORE_PATH -srcstorepass $KEY_PASS -deststorepass $KEY_PASS
echo yes | keytool -import -trustcacerts -alias $HOST -file $CERTIFICATE_PATH -keystore $TRUSTSTORE_PATH -srcstorepass $TRUSTSTORE_PASS -deststorepass $TRUSTSTORE_PASS
keytool -list -keystore $TRUSTSTORE_PATH -deststorepass $TRUSTSTORE_PASS
