# Note

Note, currently the Jenkins installation is not working. This is a work in progress.

# Packer Template for Centos 6.4 Imagesi with Jenkins

This repository contains a Packer template for building machine images
that are centos 6.4 basic images in both vmware as well as virtualbox and then uses chef to install Jenkins.

## Usage

First, [install Packer](http://www.packer.io/intro/getting-started/setup.html).
Then, clone this repository and `cd` into it.

Run the following:

```
$ packer build centos6.4-i386.json
```

You can choose to build only one type of image by running the following:

```
$ packer build -only=virtualbox centos6.4-i386.json
```

At the end of that, you'll have a virtual machine ready to go with Jenkins server installed. 