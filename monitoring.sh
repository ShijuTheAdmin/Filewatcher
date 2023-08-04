#!/bin/bash

# Set the email address to receive notifications
recipient="myemail@mydomain.com"

# Directory to monitor
monitor_dir="/home/username/public_html"

# File to store previous hash values
hash_file="/tmp/hashfile.txt"

# Function to send email notification with the list of changed items
send_email_notification() {
    echo -e "Changes detected in the 'username' directory:\n\n$changed_items" | mail -s "Directory Changes" "$recipient"
}

# Calculate SHA256 hash for files and append them to the hash file
find "$monitor_dir" -type f -not -name "error_log" -exec sha256sum {} + > "$hash_file.tmp"

# Calculate SHA256 hash for directories (only their names) and append them to the hash file
find "$monitor_dir" -type d -exec printf '%s/\n' {} + | sort | sha256sum >> "$hash_file.tmp"

# Sort the hash file to handle file and directory order changes
sort -o "$hash_file.tmp" "$hash_file.tmp"

# Compare the current and previous hash files and collect the list of changed items
changed_items=$(comm -3 "$hash_file" "$hash_file.tmp" | awk '{print $2}')

if [ -n "$changed_items" ]; then
    # Files or directories have changed, send email notification
    send_email_notification
    # Replace the old hash file with the new one
    mv "$hash_file.tmp" "$hash_file"
else
    # No changes, remove the temporary hash file
    rm "$hash_file.tmp"
fi

