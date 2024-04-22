#!/bin/bash

# Get current date
current_date=$(date +"%Y-%m-%d")

# Run squeue command to get job status for all queues
all_squeue_output=$(squeue --user=tdmusho)

# Run squeue command to get job status for tdmusho queue
tdmusho_squeue_output=$(squeue --user=tdmusho --partition=tdmusho)

# Run sinfo command to get information about partitions and nodes
sinfo_output=$(sinfo --noheader)

# Extract relevant job information for all queues
all_job_summary=$(echo "$all_squeue_output" | awk 'NR>1 {print "<tr><td>" $1 "</td><td>" $2 "</td><td>" $4 "</td><td>" $5 "</td><td>" $6 "</td></tr>"}')

# Extract relevant job information for tdmusho queue
tdmusho_job_summary=$(echo "$tdmusho_squeue_output" | awk 'NR>1 {print "<tr><td>" $1 "</td><td>" $2 "</td><td>" $4 "</td><td>" $5 "</td><td>" $6 "</td></tr>"}')

# Get total number of nodes for tdmusho queue
tdmusho_total_nodes=$(echo "$sinfo_output" | awk '/tdmusho/ {total += $4} END {print total}')

# Get total number of nodes for the whole cluster
total_nodes=$(echo "$sinfo_output" | awk '{total += $4} END {print total}')

# Calculate total utilization of the tdmusho queue
tdmusho_utilization=$(echo "$sinfo_output" | awk '/tdmusho/ {total += $7} END {print total}')

# Calculate total utilization of the whole cluster
total_utilization=$(echo "$sinfo_output" | awk '{total += $3} END {print total}')

# Calculate percentage utilization
tdmusho_utilization_percent=$(awk "BEGIN {print $tdmusho_utilization / $tdmusho_total_nodes * 100}")
total_utilization_percent=$(awk "BEGIN {print $total_utilization / $total_nodes * 100}")

# Generate summary message
summary_message="<html><head><title>SLURM Job Summary - $current_date</title></head><body>"
summary_message+="<h2>All Running Jobs Summary - $current_date</h2>"
summary_message+="<table border='1'><tr><th>Job ID</th><th>Name</th><th>User</th><th>Start Time</th><th>Time Remaining</th></tr>"
summary_message+="$all_job_summary"
summary_message+="</table>"

# Add tdmusho queue summary
summary_message+="<h2>Jobs Running on tdmusho Queue - $current_date</h2>"
summary_message+="<table border='1'><tr><th>Job ID</th><th>Name</th><th>User</th><th>Start Time</th><th>Time Remaining</th></tr>"
summary_message+="$tdmusho_job_summary"
summary_message+="</table>"

# Add total utilization information
summary_message+="<h2>Total Utilization</h2>"
summary_message+="<p>Utilization of tdmusho queue: $tdmusho_utilization / $tdmusho_total_nodes nodes ($tdmusho_utilization_percent%)</p>"
summary_message+="<p>Total cluster utilization: $total_utilization / $total_nodes nodes ($total_utilization_percent%)</p>"
summary_message+="</body></html>"

# Email summary message to user using sendmail
echo -e "From: tdmusho@trcis001.hpc.wvu.edu\nTo: tmusho+wvuhpc@gmail.com\nSubject: SLURM Job Summary - $current_date\nContent-Type: text/html\n\n$summary_message" | sendmail -t

echo "Job summary emailed to tmusho+wvuhpc@gmail.com"

