if status is-interactive
    source ~/.aliases

    function fish_greeting
        fastfetch --logo none --config ~/.config/fastfetch/config-custom.jsonc
    end

    if not set -q TMUX
        if not tmux has-session -t uwu 2>/dev/null
            tmux new-session -s uwu -d
            tmux new-window -t uwu:1
            tmux new-window -t uwu:2
        end
        exec tmux attach-session -t uwu
    end
end

