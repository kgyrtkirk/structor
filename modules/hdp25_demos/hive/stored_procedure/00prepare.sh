# Managed ETL pipeline within Hive
#
# 1. Copy data from an FTP
# 2. Stage the data into HDFS
# 3. Get the next partition ID (date + RUN ID)
# 4. Update MySQL that data will be loaded into this partition ID
# 5. Load the data
# 6. Update MySQL with success status

# Before we begin, ensure we have an FTP server running and some data there.
cd /vagrant/modules/hdp25_demos/hive/stored_procedure
sudo yum install -y pure-ftpd ftp
sudo cp pure-ftpd.conf /etc/pure-ftpd
sudo service pure-ftpd restart
echo vagrant | sudo passwd --stdin vagrant
sudo cp hplsql-site.xml /etc/hive2/conf
cp sampledata.csv /home/vagrant

# Create a tracking table in MySQL
mysql -uhive -pvagrant < mysql_setup.sql

# Stage some seed data in.
sudo -u hdfs hdfs dfs -copyFromLocal citydata.db /apps/hive/warehouse
sudo -u hdfs hdfs dfs -chown -R vagrant:vagrant /apps/hive/warehouse/citydata.db
