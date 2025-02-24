if status is-interactive
    set PATH ~/bin $PATH
    set PATH ~/.local/bin $PATH

    for brewpath in /home/linuxbrew/.linuxbrew/bin/brew /opt/homebrew/bin/brew
        if test -f $brewpath
            eval "$($brewpath shellenv)"
            break
        end
    end

    chezmoi completion fish | source
    starship init fish | source

    function fish_greeting
        if type -q fastfetch
            fastfetch
        end
    end
end
