#!/usr/bin/env bash

# Exit on failure or pipe failure
set -e -o pipefail

# Clean up lock if killed
# If killed by systemd, like $(systemctl stop restic), then it kills the whole cgroup and all it's subprocesses.
# However if we kill this script ourselves, we need this trap that kills all subprocesses manually.
exit_hook() {
    echo "In exit_hook(), being killed" >&2
    jobs -p | xargs kill
    restic unlock
}
trap exit_hook INT TERM

# How many backups to keep.
RETENTION_DAYS=14
RETENTION_WEEKS=16
RETENTION_MONTHS=18
RETENTION_YEARS=3

# Exclude and include files
HOME_EXCLUDE="--exclude-file /home/zaayer/.config/restic/excludes.txt"
ETC_INCLUDE="--files-from /home/zaayer/.config/restic/includes.txt"

# Set all environment variables like
# B2_ACCOUNT_ID, B2_ACCOUNT_KEY, RESTIC_REPOSITORY etc.
source /home/zaayer/.local/share/apikeys/restic.sh

# How many network connections to set up to B2. Default is 5.
B2_CONNECTIONS=50

# NOTE start all commands in background and wait for them to finish.
# Reason: bash ignores any signals while child process is executing and thus my trap exit hook is not triggered.
# However if put in subprocesses, wait(1) waits until the process finishes OR signal is received.
# Reference: https://unix.stackexchange.com/questions/146756/forward-sigterm-to-child-in-bash

# Remove locks from other stale processes to keep the automated backup running.
restic unlock &
wait $!

# Do the backups!
# See restic-backup(1) or http://restic.readthedocs.io/en/latest/040_backup.html
# --one-file-system makes sure we only backup exactly those mounted file systems specified in $BACKUP_PATHS, and thus not directories like /dev, /sys etc.
# --tag lets us reference these backups later when doing restic-forget.
restic backup \
    --verbose \
    --tag home \
    --option b2.connections=$B2_CONNECTIONS \
    $HOME_EXCLUDE \
    /home/zaayer &
wait $!

restic backup \
    --verbose \
    --tag modetc \
    --option b2.connections=$B2_CONNECTIONS \
    $ETC_INCLUDE &
wait $!

restic backup \
    --verbose \
    --tag boot \
    --option b2.connections=$B2_CONNECTIONS \
    /boot &
wait $!

# # Dereference old backups.
# # See restic-forget(1) or http://restic.readthedocs.io/en/latest/060_forget.html
# # --group-by only the tag and path, and not by hostname. This is because I create a B2 Bucket per host, and if this hostname accidentially change some time, there would now be multiple backup sets.
# restic forget \
#     --verbose \
#     --tag $BACKUP_TAG \
#     --group-by "paths,tags" \
#     --keep-daily $RETENTION_DAYS \
#     --keep-weekly $RETENTION_WEEKS \
#     --keep-monthly $RETENTION_MONTHS \
#     --keep-yearly $RETENTION_YEARS &
# wait $!

# # Remove old data not linked anymore.
# # See restic-prune(1) or http://restic.readthedocs.io/en/latest/060_forget.html
# restic prune \
#     --option b2.connections=$B2_CONNECTIONS \
#     --verbose &
# wait $!

echo "Backup is done."
