###########################
# Vagantでプロピジョニング設定で使用する用
# Vagrant.configure("2") do |config|
#   config.vm.box = "centos/7"
#   config.vm.hostname = "centos7"
#   config.vm.network "forwarded_port", guest: 80, host: 8080
#   config.vm.network "private_network", ip: "192.168.33.10"
#   config.vm.synced_folder "./web/", "/home/vagrant/web/"
#   config.vm.provision :shell, :path => "bootstrap.sh" // ここで実行する用
# end
###########################

###########################
# 環境構築系（LAMP環境構築）
###########################

###########################
# package関連
###########################

# packageのupdate
sudo yum -y update & pid1=$! 
    wait $pid1

# packageのinstall
# - wget
# - git
# - zip
# - unzip
sudo yum -y install wget git zip unzip & pid2=$! 
    wait $pid2

###########################
# LAMP（Apache）のインストール
###########################

# Apacheのインストール
sudo yum -y install httpd & pid3=$! 
    wait $pid3

# 自動でApacheが起動できるようにする
systemctl enable httpd.service & pid4=$! 
    wait $pid4

# ファイアーウォールの解除
# systemctl stop firewalld.service

# var/www/html/ の権限をvagrantに変更
sudo chown vagrant /var/www/html/

###########################
# LAMP（MySQLのインストール）
###########################
sudo yum -y install http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm & pid5=$! 
    wait $pid5

sudo yum -y install mysql mysql-devel mysql-server mysql-utilities & pid6=$i 
    wait $pid6

###########################
# LAMP（PHPのインストール）
###########################
# epelのinstall
sudo yum -y install epel-release & pid7=$! 
    wait $pid7

# epelのリポジトリ作成
sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm & pid8=$! 
    wait $pid8

# PHPで必要なモジュールを入れる
sudo yum install -y --enablerepo=remi,remi-php71 php-common php-pdo php-cli php-devel php-mysqlnd php-mbstring php-gd php-intl php-xml php-bcmath & pid9=$! 
    wait $pid9

##########################
# Nodeのinstall
##########################
# nvm(node version managerのインストール)
git clone https://github.com/creationix/nvm.git ~/.nvm & pid10=$! 
    wait $pid10

# 反映させる
source ~/.nvm/nvm.sh

# nvmを利用して、nodeとnpmを入れる
nvm install stable & pid11=$! 
    wait $pid11

# bash_profileに記述
echo -e "if [[ -s ~/.nvm/nvm.sh ]]; then \n source ~/.nvm/nvm.sh \nfi" >> .bash_profile

##########################
# php.iniの設定を変更する（/etc/php.ini）
##########################

################
# ログ関連
################c
# phpに関連するエラーログを/var/log/php.logに吐くように設定
sudo sed -i -e "/^;error_log = syslog$/a error_log=\/var\/log\/php\.log" php.ini

################
# TimeZone
################
sudo sed -i -e 's/^;date\.timezone =$/date\.timezone = "Asia\/Tokyo"/g' php.ini

################
# 文字コード関連
################
sudo sed -i -e "s/;mbstring\.language = Japanese/mbstring\.language = Japanese/g" php.ini

################
# メモリ関連
################
sudo sed -i -e "s/post_max_size = 8M/post_max_size = 16M/g" php.ini

################
# セキュリティ関連
################
# レスポンスヘッダにPHPのバージョン情報などが露呈してしまうためOFF
sudo sed -i -e "s/expose_php = On/expose_php = Off/g" php.ini

# セッション ID 文字列の長さを128bitに変更
sudo sed -i -e "s/session.sid_length = 26/session.sid_length = 256/g" php.ini


##############
# DBサーバー用
##############
# mysql5.7をinstall
# sudo yum install -y mysql57-server

# サーバーを立ち上げた段階で自動的にmysqlが起動する
# sudo chkconfig mysqld on

# mysqlの起動
# sudo service mysqld start

