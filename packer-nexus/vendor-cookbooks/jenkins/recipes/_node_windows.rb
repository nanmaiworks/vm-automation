#
# Cookbook Name:: jenkins
# Recipe:: node_windows
#
# Author:: Doug MacEachern <dougm@vmware.com>
# Author:: Fletcher Nichol <fnichol@nichol.ca>
#
# Copyright 2010, VMware, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'java::default'

home_dir = node['jenkins']['node']['home']
server_url = node['jenkins']['server']['url']

jenkins_exe = "#{home_dir}\\jenkins-slave.exe"
service_name = 'jenkinsslave'

directory home_dir do
  action :create
end

env 'JENKINS_HOME' do
  action :create
  value home_dir
end

env 'JENKINS_URL' do
  action :create
  value server_url
end

jenkins_node node['jenkins']['node']['name'] do
  description  node['jenkins']['node']['description']
  executors    node['jenkins']['node']['executors']
  remote_fs    node['jenkins']['node']['home']
  labels       node['jenkins']['node']['labels']
  mode         node['jenkins']['node']['mode']
  launcher     node['jenkins']['node']['launcher']
  mode         node['jenkins']['node']['mode']
  availability node['jenkins']['node']['availability']
end

remote_file "#{home_dir}\\slave.jar" do
  source "#{server_url}/jnlpJars/slave.jar"
  notifies :restart, "service[#{service_name}]", :immediately
end

cookbook_file "#{node['jenkins']['node']['home']}/node_info.groovy" do
  source 'node_info.groovy'
end

secret = ''
jenkins_cli "node_info for #{node['jenkins']['node']['name']} to get jnlp secret" do
  command "groovy node_info.groovy #{node['jenkins']['node']['name']}"
  block do |stdout|
    current_node = JSON.parse(stdout)
    secret.replace current_node['secret'] if current_node['secret']
  end
end

template "#{home_dir}/jenkins-slave.xml" do
  source 'jenkins-slave.xml.erb'
  variables(:jenkins_home => home_dir,
            :jnlp_url => "#{server_url}/computer/#{node['jenkins']['node']['name']}/slave-agent.jnlp",
            :jnlp_secret => secret)
  notifies :restart, "service[#{service_name}]"
end

remote_file jenkins_exe do
  source node['jenkins']['node']['winsw_url']
  not_if { File.exists?(jenkins_exe) }
end

execute "#{jenkins_exe} install" do
  cwd home_dir
  only_if { WMI::Win32_Service.find(:first, :conditions => { :name => service_name }).nil? }
end

service_account = node['jenkins']['node']['service_user']
#
# The allowed values for account that service can run as are:
# * LocalSystem => Default. Service runs with the machine account.
# * .\Administrator => Local Account.
# * domain\username => Domain Account.
#

# Make sure account name is converted to a local account name if
# needed.
if service_account != 'LocalSystem' && !service_account.include?('\\')
  service_account = ".\\#{service_account}"
end

service_cred_command = "sc config #{service_name} obj= #{service_account}"

# Password is not necessary if the service is running as LocalSystem
if service_account != 'LocalSystem'
  service_cred_command += " password= #{node['jenkins']['node']['service_user_password']}"
end

execute service_cred_command do
  only_if do
    service = WMI::Win32_Service.find(:first, :conditions => { :name => service_name })
    !service.nil? && service.startName != service_account
  end

  notifies :restart, "service[#{service_name}]", :immediately
end

service service_name do
  action :start
  only_if { !WMI::Win32_Service.find(:first, :conditions => { :name => service_name }).nil? }
end
