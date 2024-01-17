#!/bin/bash

# Path to the CSV file containing candidate information (name, email)
candidates_csv="/workspaces/ShellScripting_EmailNotifs/candidates.csv"

# Email configuration
subject="Campaign Update"
body="Dear [Candidate],\n\nWe appreciate your continued support in our campaign. Here is a weekly update on our progress.\n\nBest regards,\n[Sharan]"

# Get the current day of the week
day_of_week=$(date +%u)

# Check if today is Monday (day_of_week=1)
if [ "$day_of_week" -eq 3 ]; then
    # Loop through each line in the CSV file
    tail -n +2 "$candidates_csv" | while IFS=, read -r name email; do
        # Use mutt to send emails
        mutt -s "$subject" "$email" <<< "$(echo -e "$body" | sed "s/\[Candidate\]/$name/g; s/\[Your Name\]/Your Name/g")"
        echo "Email sent to $name at $email"
    done
else
    echo "Today is not Monday. No emails will be sent."
fi
