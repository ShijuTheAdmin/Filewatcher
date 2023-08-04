# Filewatcher
To monitor changes to files and directories and send email notifications

This script will generate sha256sum hashes for each file in the '/home/username/public_html/' directory and save it to a file (/tmp/hashfile.txt). That file will be used to compare the hash changes when the script runs next time.

If the script finds a discrepancy between a file hash and a saved hash for that particular file, it will send notifications to an email address mentioned in that script as "recipient".

It will be very useful on servers running "Auditd". When a new notification is received, the user can check the "audit.log" for more information about the change.
