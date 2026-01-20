
# Helper functions
function saveToFile
    echo $argv[1] > "$HOME/.config/fish/usr/data/.current_gh"
end

function openFile
    read -l account_info < "$HOME/.config/fish/usr/data/.current_gh"
    echo $account_info
end

function setGitHubAccount
    saveToFile $argv[1]
end

function getGitHubAccount
    read -l last_account_used < "$HOME/.config/fish/usr/data/.current_gh"
    echo $last_account_used
end

# Driver function
function getGitHubAccountInfoIfActive
    # This function will return and save the active GitHub account name if it is active
    set account_info (gh auth status | awk '
        /Active account: true/ {
            # Get the previous line
            if (prev_line ~ /account/) {
                # Extract the account name (second to last field)
                split(prev_line, parts)
                print parts[length(parts)-1] " (active)"
            }
            exit
        }
        { prev_line = $0 }
    ')

    setGitHubAccount $account_info

    # Return the account info
    echo $account_info
end


# Helper function that allows the user to switch git accounts easier from the terminal
function switchGitHubAccount
    set account_info (getGitHubAccountInfoIfActive) # Get the active GitHub account name
    gh auth switch 2>&1 | grep -q "✓ Switched active account for github.com to"
    set new_current_shell (getGitHubAccountInfoIfActive)
    echo (set_color green)"Switched GitHub account to: "(set_color yellow)$new_current_shell(set_color normal)
    setGitHubAccount $new_current_shell
end

function gh_account_parser
    set functional_argv $argv
    if test (count $functional_argv) -gt 0
        if test $functional_argv[1] = 'switch'
            switchGitHubAccount
        end
    end
end

function gh_account
    gh_account_parser $argv
end
