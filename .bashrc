source ~/.bash_aliases

function man {
    local section=all
    if [[ "$1" =~ ^[0-9]+$ ]]; then section="$1"; shift; fi
    local doc="$(curl -v --silent --data-urlencode topic="$@" --data-urlencode section="$section" http://man.he.net/ 2>&1)"
    local ok=$?
    local pre="$(printf '%s' "$doc" | sed -ne "/<PRE>/,/<\/PRE>/ { /<PRE>/ { n; b; }; p }")"
    [[ $ok -eq 0 && -n "$pre" ]] && printf '%s' "$pre" | less || printf 'Got nothing.\n' >&2
    return $ok
}


export PS1="\n\[\e[32m\]\t\[\e[m\] \[\e[35m\]\u\[\e[m\] \[\e[33m\]\w\[\e[m\]\[\e[36m\]\`__git_ps1\`\[\e[m\] $\n"

export PATH=/c/Program\ Files/Java/jdk1.8.0_172/bin:~/mvn/apache-maven-3.5.2/bin:$PATH

