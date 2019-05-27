###########################
# Virtual Boxの追加（Vagrantをインストール済みと仮定）
# http://www.vagrantbox.es/
###########################vagra
vagrant box add centos7.1 https://github.com/holms/vagrant-centos7-box/releases/download/7.1.1503.001/CentOS-7.1.1503-x86_64-netboot.box

# 仮想でサーバーを立てたいディレクトリで実行
vagrant init CentOS7.1

# IPアドレスを192.168.33.10に変更
sed -i '' -e 's/# config.vm.network "private_network", ip: "192.168.33.10"/config.vm.network "private_network", ip: "192.168.33.10"/' Vagrantfile

# 共有フォルダの設定を行うためのプラグインを入れる
vagrant plugin install vbguest

# Vagrant.configure(2) do |config|
#   config.vm.box = "CentOS7.1"
#   config.vm.network "private_network", ip: "192.168.33.10"
#    config.vm.synced_folder "./Project", "/home/vagrant/CentOS/Project" // 適宜変更
# end
