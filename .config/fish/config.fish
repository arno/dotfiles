if status is-interactive
    # Commands to run in interactive sessions can go here
    set -x LESS '-FRSXi'
    set -x LESSCHARSET 'UTF-8'
    set -x LESS_TERMCAP_mb \e\[01\;31m
    set -x LESS_TERMCAP_md \e\[01\;31m
    set -x LESS_TERMCAP_me \e\[0m
    set -x LESS_TERMCAP_se \e\[0m
    set -x LESS_TERMCAP_so \e\[01\;44\;33m
    set -x LESS_TERMCAP_ue \e\[0m
    set -x LESS_TERMCAP_us \e\[01\;32m

    set -x PAGER less

    set -x EDITOR nvim
    set -x VISUAL nvim
    set -x MAIL ~/Maildir
    set -x PYTHONSTARTUP ~/.pythonrc
    set -x MANPATH ~/.local/share/man:(manpath)
    set -x RIPGREP_CONFIG_PATH ~/.config/ripgrep/ripgreprc

    set -x PATH $PATH ~/local/bin ~/.local/bin ~/go/bin ~/.cargo/bin
end
