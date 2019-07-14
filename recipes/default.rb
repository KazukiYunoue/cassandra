#
# Cookbook:: cassandra
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

yum_repository "cassandra" do
  description "Apache Cassandra"
  baseurl "https://www.apache.org/dist/cassandra/redhat/311x/"
  gpgcheck true
  repo_gpgcheck true
  gpgkey "https://www.apache.org/dist/cassandra/KEYS"
end

package "cassandra" do
  action :install
end

service "cassandra" do
  action [:enable, :start]
  supports :status => true, :restart => true
end

template "/etc/cassandra/conf/cassandra-env.sh" do
  source "cassandra-env.sh.erb"
  user "root"
  group "root"
  mode 0644
  notifies :restart, "service[cassandra]"
end

template "/etc/cassandra/conf/cassandra.yaml" do
  source "cassandra.yaml.erb"
  user "root"
  group "root"
  mode 0644
  notifies :restart, "service[cassandra]"
end
