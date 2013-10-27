# from http://www.wikihow.com/Install-Oracle-Java-JRE-on-Ubuntu-Linux

# Download Oracle JRE from http://www.oracle.com/technetwork/java/javase/downloads/index.html
# into ~/soft

cd ~/soft
sudo mkdir /usr/local/java
sudo cp -r jre-7u45-linux-i586.tar.gz /usr/local/java
cd /usr/local/java/
sudo chmod a+x jre-7u45-linux-i586.tar.gz
sudo tar xvzf jre-7u45-linux-i586.tar.gz
sudo update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/jre1.7.0_45/bin/java" 1
sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/local/java/jre1.7.0_45/bin/javaws" 1
sudo update-alternatives --set java /usr/local/java/jre1.7.0_45/bin/java
sudo update-alternatives --set javaws /usr/local/java/jre1.7.0_45/bin/javaws
. /etc/profile

# test
java -version
