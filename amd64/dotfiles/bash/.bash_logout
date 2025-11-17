# ~/.bash_logout: executed by bash(1) when login shell exits.

# when leaving the console clear the screen to increase privacy

if [ "$SHLVL" = 1 ]; then
    
    # Clear the console screen
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q

    # Clear the in-memory history of the current session
    # so it doesn't get written to the file on exit.
    history -c

    # 'shred' overwrites the file to make recovery difficult.
    # The '-u' flag also removes the file after overwriting.
    if [ -f ~/.bash_history ]; then
        shred -u ~/.bash_history
    fi
fi
