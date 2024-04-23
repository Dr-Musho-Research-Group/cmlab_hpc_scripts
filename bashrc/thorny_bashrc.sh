# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias grep="grep -n"
alias qinfo="scontrol show jobid -dd"

#
#
#  Auto Starts
#
#
# Automatically start tmux on login if connecting to specific hostname
if [ -z "$TMUX" ] && [ "$(hostname)" = "trcis001.hpc.wvu.edu" ]; then
    tmux attach-session -t default || tmux new-session -s default
fi


#
#
#   Custom Scripts and Commands
#
#
backup() {
    if [ $# -eq 0 ]; then
        echo "Usage: backup filename"
        return 1
    fi

    local filename="$1"
    local backup_dir="$HOME/backup/$(date +'%Y-%m-%d_%H-%M-%S')"

    if [ ! -d "$backup_dir" ]; then
        mkdir -p "$backup_dir" || { echo "Failed to create backup directory."; return 1; }
    fi

    if [ -e "$filename" ]; then
        cp "$filename" "$backup_dir" || { echo "Failed to backup file."; return 1; }
        echo "Backup successful: $filename -> $backup_dir"
    else
        echo "File not found: $filename"
        return 1
    fi
}

#
#
#   Colors
#
#
#
#PS1='\[\e[1;32m\]\u@\h \[\e[1;34m\]\w\[\e[0m\]\$ '
PS1='\[\e[1;32m\]\u@\h \[\e[1;36m\]\w\[\e[0m\]\$ '
set_title() {
    echo -ne "\033]0;$@\007"
}