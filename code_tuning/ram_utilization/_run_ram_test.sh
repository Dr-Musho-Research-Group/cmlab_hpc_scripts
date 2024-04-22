#!/bin/bash

# Global variable to store RAM change
initial_ram_utilization=0
max_ram_change=0

# Temporary file to store RAM change
temp_file=$(mktemp)

# Function to measure initial RAM utilization
measure_initial_ram_utilization() {
    initial_ram_utilization=$(free | awk '/Mem/ {printf "%.3f\n", $3 / 1024 / 1024}')
}

# Function to continuously monitor RAM utilization and calculate the change
monitor_and_calculate_ram_change() {
    while true; do
        current_ram_utilization=$(free | awk '/Mem/ {printf "%.3f\n", $3 / 1024 / 1024}')
        ram_change=$(echo "$current_ram_utilization - $initial_ram_utilization" | bc)
        if (( $(echo "$ram_change > $max_ram_change" | bc -l) )); then
            max_ram_change=$ram_change
            echo "$max_ram_change" > "$temp_file"
        fi
        echo "Current RAM utilization: $current_ram_utilization GB, Initial RAM utilization: $initial_ram_utilization GB, RAM change: $ram_change GB, Max RAM change: $max_ram_change GB"
        sleep 1
    done
}

# Main function
main() {
    # Clean
    rm *.dat *.vtk *.out *.txt

    # Measure initial RAM utilization
    measure_initial_ram_utilization

    # Start monitoring RAM utilization and calculating the change in the background
    monitor_and_calculate_ram_change &
    monitor_pid=$!

    # Record start time
    start_time=$(date +%s)

    # Execute ../src_double_tip_cpu/gfed with the provided command line arguments and timeout after 1 minute
    echo "Executing ../src_double_tip_cpu/gfed with a timeout of 30 seconds..."
    timeout 30s ../src_double_tip_cpu/gfed -d 10 30e-10 30e-10 30e-10 30e-10 30e-10 30e-10 300 300 2000 0 10 5 1 0.6 1.0 0.0 0.4 0.0

    # Record end time
    end_time=$(date +%s)

    # Calculate execution time
    execution_time=$((end_time - start_time))

    # Read max RAM change from temporary file
    max_ram_change=$(cat "$temp_file")

    echo "RAM utilization change: $max_ram_change GB"
    echo "Execution time: $execution_time seconds"

    # Stop the RAM utilization monitoring process
    kill $monitor_pid

    # Write RAM change and execution time to a file
    echo "RAM utilization change: $max_ram_change GB" >> execution_info.txt
    echo "Execution time: $execution_time seconds" >> execution_info.txt

    # Remove temporary file
    rm "$temp_file"
}

# Execute the main function
main
