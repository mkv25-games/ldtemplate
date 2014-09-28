mkv25.net's Ludum Dare Deployment System
========================================

This grunt plugin manages the release and deployment of new versions of Ludum Dare entries.
It contains a bunch of scripts to automate the release procedure, including:
+ Bumping the release version (r1, r2, r3, etc.)
+ Converting index.template.html into index.html - and writing in the current build
+ Uploading files via FTP to a web server

Setup
-----
This deployment system is designed to work with a specific folder structure, probably best to check out the full Ludum Dare Template, which includes this deployment script.

+ Copy / rename .ftppass-template to .ftppass
+ Populate .ftppass with FTP Username and Password details
 
Configuration
-------------
Other variables you might want to change, include:

gruntfile.js:
```javasrcipt
	var FTP_HOST = 'ftp.mkv25.net';
	var FTP_USER = 'grunt-ludum'
	var FTP_PATH = '';
```

Wishlist
--------
+ Build Windows and Android versions as part of release
+ Make a tweet with the new response
+ Include any/all screen shots into the template
