vm-automation
=============

Repository code for virtual images automation

# Pre Requisities

Installation of Packer,Virtual Box ,Berkshelf and Ruby.  
Host and guest machines (virtual box) are connected in bridge adapter mode.
Basic knowledge on chef. 

# Packer Template for Centos 6.4 

This repository contains a Packer template for building machine images
that are centos 6.4 basic images in both vmware as well as virtualbox and then uses chef to install Jenkins,Nexus and Maven
to run Jenkins Job.

  
# Reference

http://www.packer.io.
http://www.berkshelf.com.
http://christophermaier.name/blog/2010/09/01/host-only-networking-with-virtualbox.
https://www.virtualbox.org.
https://learnchef.opscode.com.‎
