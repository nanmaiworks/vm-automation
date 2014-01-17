# Packer Template for Centos 6.4 Imagesi with Jenkins

This repository contains a Packer template for building machine images
that are centos 6.4 basic images in both vmware as well as virtualbox and then uses chef to install Jenkins.

## Usage
Make sure all the Pre Requisities are met as mentioned in the root README.md file.
Then, clone this repository and `cd` into it.

Run the following:

```
$ packer build jenkins.json

```

You can choose to build only one type of image by running the following:

```
$  packer build --only = virtualbox jenkins.json      

(on execution of above command delete the jenkins cookbook inside vendor-cookbooks and copy the jenkins cookbook 
from nonopscode-cookbooks present in the root directory )

```

At the end of that, you'll have a virtual machine ready to go with Jenkins server installed. 
