nexus-metadata
=============

# Pre Requisities
Step by step guide of nexus - http://books.sonatype.com/nexus-book/reference/_nexus_prerequisites.html 

Download nexus --http://www.sonatype.org/nexus/go?__utma=246996102.259449106.1393295651.1393295651.1393295651.1&__utmb=246996102.3.9.1393295666510&__utmc=246996102&__utmx=-&__utmz=246996102.1393295651.1.1.utmcsr=books.sonatype.com|utmccn=(referral)|utmcmd=referral|utmcct=/nexus-book/reference/install-sect-downloading.html&__utmv=-&__utmk=50432554

# Installing nexus

sudo cp /<nexus-download-folder> to /usr/local/<nexus.zip>
cd /usr/local/<nexus.zip>
unzip <nexus.zip>
chmod -R 777 <nexus_folder>
chmod -R 777 sonatype-work

# Start nexus

cd /use/local/<nexus_folder>
./bin/nexus console

# Check status
tail -f logs/wrapper.log (check status of nexus)
http://localhost:8081/nexus
