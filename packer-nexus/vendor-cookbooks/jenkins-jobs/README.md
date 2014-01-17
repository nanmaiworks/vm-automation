Description
===========

Installs Jenkins CI jobs using the chef-jenkins `jenkins_job` provider in the
upstream Jenkins cookbook.

Attributes
==========

* `default[:jenkins_jobs][:git_root]` - The root Git location for things tested by Jenkins
* `default[:jenkins_jobs][:git_user]` - The Git user name to use when checking out a repo
* `default[:jenkins_jobs][:git_email]` - The email address to use for the Git user
* `default[:jenkins_jobs][:check_chef_spec_repos]` - A list of repo names
  (appended to `node[:jenkins_jobs][:git_root`) that the checks recipe will automatically
  create Jenkins jobs for that runs ChefSpec tests

Templates
=========

Each Jenkins job is configured in an XML file that is written to the Jenkins
home directory. The configuration XML files are templatized and contained
in this cookbook's templates/ directory.

Usage
=====

The recipes in this cookbook are divided into test job types. Add the recipe
to the role `run_list` for the CI server you use.

For example:

    knife node run_list add <MY_CI_NODE> jenkins_jobs::checks

License and Author
==================

Author:: Jay Pipes (<jaypipes@gmail.com>)

Copyright:: 2012, Jay Pipes

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
