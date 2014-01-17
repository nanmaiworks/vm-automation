#
# Cookbook Name:: jenkins-jobs
# Recipe:: checks
#
# Copyright 2012, Jay Pipes
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# A few things we use in all of the Jenkins job XML config templates...
git_root = node[:jenkins_jobs][:git_root]
git_user = node[:jenkins_jobs][:git_user]
git_email = node[:jenkins_jobs][:git_email]

# The main check of the chef-repo
job_name = "check-chef-repo"
job_config = File.join(node[:jenkins][:server][:home], "#{job_name}.xml")

jenkins_job job_name do
  action :nothing
  config job_config
end

template job_config do
  source "check-chef-repo.xml.erb"
  variables :git_root => git_root,
            :git_user => git_user,
            :git_email => git_email
  notifies :update, resources(:jenkins_job => job_name), :immediately
  notifies :build, resources(:jenkins_job => job_name), :immediately
end

# Add ChefSpec testing jobs
chef_spec_repos = node[:jenkins_jobs][:check_chef_spec_repos]

chef_spec_repos.each do |repo|
  test_job = "check-chef-spec-#{repo}"
  job_config = File.join(node[:jenkins][:server][:home], "#{test_job}-config.xml")

  jenkins_job test_job do
    action :nothing
    config job_config
  end

  template job_config do
    source "check-chef-spec-cookbook.xml.erb"
    variables :repo => repo,
              :repo_spec_name => repo.sub(/cookbook-/, ""),
              :git_root => git_root,
              :git_user => git_user,
              :git_email => git_email
    notifies :update, resources(:jenkins_job => test_job), :immediately
    notifies :build, resources(:jenkins_job => test_job), :immediately
  end
  
end
