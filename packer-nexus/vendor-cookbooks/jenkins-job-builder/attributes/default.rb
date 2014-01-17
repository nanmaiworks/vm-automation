default['jenkins_job_builder']['user'] = 'vagrant'
default['jenkins_job_builder']['group'] = value_for_platform_family(
  ['debian'] => "vagrant",
  ['rhel','fedora','suse'] => "vagrant"
)
default['jenkins_job_builder']['username'] = 'vagrant'
default['jenkins_job_builder']['password'] = 'vagrant'
default['jenkins_job_builder']['url'] = 'git://github.com/blackburntech/jpetstore-sample'
default['jenkins_job_builder']['version'] = '0.4.0'
default['jenkins_job_builder']['from_source'] = nil
default['jenkins_job_builder']['repo'] = 'git+git://github.com/blackburntech/jpetstore-sample'
default['jenkins_job_builder']['hipchat_token'] = nil
