#!/usr/bin/env bash

_pw_completions() {
    [[ -z "$PW_DIR" ]] && PW_DIR="$HOME/.pw"
    prefix="$PW_DIR/"
    suffix=".gpg"
    local IFS=$'\n'
    items=($(compgen -f "$PW_DIR/"))
    for item in "${items[@]}"; do
		item="${item%$suffix}"
        COMPREPLY+=("${item#$prefix}")
    done
}

complete -F _pw_completions "pw"
