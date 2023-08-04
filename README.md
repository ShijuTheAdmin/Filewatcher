# Filewatcher
To monitor changes in files and directories and send email notifications

This script will generate sha256sum hash for every file in the '/home/username/public_html/' directory and save it in to a file (/tmp/hashfile.txt). 
That file will then use to compair changes to the hash when script runs next time. 

If the script find any missmatches for a file hash and saved hash for that particualr file, it will send a notification to an email address mentioned in that script. 

It will be super useful on servers that run "Auditd". When a new notification received, the user can check "audit.log" for more information about the change.
