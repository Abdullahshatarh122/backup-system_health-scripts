# Linux Backup & System Health Report Scripts

## Backup Shell Script

### 🔹 Overview
The **Backup Script** allows users to specify multiple files and directories for backup. It compresses the selected items into timestamped archives and logs all activities.

###  Features
- **Interactive Selection**: Prompts user for the number of files/directories to back up.
- **Validation Checks**: Ensures valid input and path existence.
- **Automated Backups**: Saves backups in a dedicated directory.
- **Logging**: Maintains a log of all backup operations.
- **Parallel Processing Support**: Can be enhanced with GNU Parallel.

###  Implementation Details
1. **User Input**: Script prompts for the number of files/directories to back up.
2. **Path Validation**: Verifies if entered paths exist before proceeding.
3. **Backup Directory**: Creates a `backups` folder in the user's home directory.
4. **Archiving & Compression**: Uses `tar -czvf` for creating compressed backup files.
5. **Logging**: Stores backup details in `backups_log.log`.


##  System Health Report Script

### 🔹 Overview
The **System Health Report Script** generates a detailed system status report, logging crucial system metrics like CPU, memory, disk usage, active services and recent updates.

###  Features
- **Disk Space Monitoring**: Uses `df -h` to analyze disk usage.
- **Memory Usage Report**: Displays available and used RAM.
- **Running Services**: Lists currently active system services.
- **Recent Updates Log**: Extracts updates performed in the last 7 days.
- **Logging**: Saves the report to a file for review.

### Implementation Details
1. **Timestamping**: Logs include a timestamp for each report.
2. **Disk & Memory Usage**: Extracted using `df -h` and `free -h`.
3. **Running Services**: Listed via `systemctl list-units`.
4. **Recent Updates**: Filters logs from `/var/log/dpkg.log`.
5. **Logging**: Reports are saved in `$HOME/system_health.log`.

## Conclusion
These scripts enhance **system reliability and performance monitoring**. By automating backups and system reports, they help users prevent data loss and detect system issues early. 🚀

