maintainer          "Jay Pipes"
maintainer_email    "jaypipes@gmail.com"
license             "Apache 2.0"
description         "Cookbook for managing Jenkins Jobs via source control"
long_description    IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version             "0.1.3"

recipe              "jenkins-jobs::checks", "Installs jobs into the jenkins server"

%w{ debian ubuntu }.each do |os|
  supports os
end

depends             "jenkins"
