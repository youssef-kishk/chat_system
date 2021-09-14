wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.14.1-linux-x86_64.tar.gz
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.14.1-linux-x86_64.tar.gz.sha512
shasum -a 512 -c elasticsearch-7.14.1-linux-x86_64.tar.gz.sha512 
tar -xzf elasticsearch-7.14.1-linux-x86_64.tar.gz
cd elasticsearch-7.14.1/
./bin/elasticsearch