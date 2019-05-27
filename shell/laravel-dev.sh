####################
# Laravelの環境構築（Laravelを動かしたいところで実行する）
####################

# phpのバージョンを7以上に設定する
sudo yum install -y --disablerepo=* --enablerepo=remi,remi-php71 php 

# Composerのinstall
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

# Composerを使用できるようにPATHを変更
sudo mv composer.phar /usr/local/bin/composer

# アクセス権を設定
sudo chmod a+x /usr/local/bin/composer 

# Composerのversion確認
composer --version
if $? -eq 1 ; then 
    echo 'Composerがうまくインストールされていません。処理を終了します。'
    echo 'Composerをインストールする手順を見直してください';
    exit;
fi

# Composerを使用してLaravelをinstall
composer global require "laravel/installer=1.1"

# Composerを使用してLaravelProjectを作成
composer create-project --prefer-dist laravel/laravel web_samp

# Laravelでserverを立ち上げる
# php artisan serve

# 上記でserverが立ち上がらなかった場合
# composer install

# 上記のコマンドで立ち上がらない場合host portを指定してサーバーを立ち上げる
# php artisan serve --host 192.168.33.10 --port 8000

# firewallの設定無効にする（これがあるとビルドインサーバーに接続できない
# systemctl stop firewalld.service

# firewallの自動起動解除
# systemctl disable firewalld

# firewallの自動起動設定確認
# systemctl is-enabled firewalld

# firewallの自動起動設定起動
# systemctl enabled firewalld

# MySQLの自動起動
# systemctl enable mysqld.service

# MySQLの起動
# systemctl start mysqld.service

# 上記でも接続できない場合はkeyを生成し、再度接続
# php artisan key:generate

# LaravelMixで以下のパッケージが必要になるのでインストール
sudo yum install -y bash gcc make libpng-devel

# sqliteのインストール
sudo yum -y install sqlite
