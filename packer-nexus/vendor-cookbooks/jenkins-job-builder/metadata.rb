name                'jenkins-job-builder'
maintainer          'Cameron Johnston'
maintainer_email    'cameron@needle.com'
license             'Apache 2.0'
description         'Installs and configures jenkins-job-builder, provides reusable build_jenkins_job definition'
long_description    IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version             '0.0.11'

depends 'python'
depends 'yum'
recommends 'jenkins'
