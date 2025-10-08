# File listing (using native Nushell ls for structured data)
alias ll = ls -l
alias lsa = ls -a
alias lla = ls -la

# Safe file operations
alias mv = mv -i
alias cp = cp -i

# Editor
alias vim = nvim

# Pretty tokei summary table
def tokei-summary [...args] {
    if (which tokei | is-empty) {
        print "tokei is not installed"
        return
    }

    tokei -o json ...$args
    | from json
    | transpose language data
    | where language != "Total"
    | select language data
    | insert files { |row| ($row.data.reports | length) }
    | insert lines { |row| $row.data.blanks + $row.data.code + $row.data.comments }
    | insert code { |row| $row.data.code }
    | insert comments { |row| $row.data.comments }
    | insert blanks { |row| $row.data.blanks }
    | select language files lines code comments blanks
    | sort-by -r code
}

# Tokei analysis with percentages and ratios
def tokei-analysis [...args] {
    if (which tokei | is-empty) {
        print "tokei is not installed"
        return
    }

    let data = (tokei -o json ...$args | from json | transpose language data | where language != "Total")
    let total_code = ($data | get data.code | math sum)

    $data
    | select language data
    | insert files { |row| ($row.data.reports | length) }
    | insert lines { |row| $row.data.blanks + $row.data.code + $row.data.comments }
    | insert code { |row| $row.data.code }
    | insert comments { |row| $row.data.comments }
    | insert blanks { |row| $row.data.blanks }
    | insert code_pct { |row| ($row.data.code / $total_code * 100) | math round --precision 1 }
    | insert comment_ratio { |row|
        if $row.data.code > 0 {
            ($row.data.comments / $row.data.code * 100) | math round --precision 1
        } else { 0 }
    }
    | select language files lines code code_pct comments comment_ratio blanks
    | sort-by -r code
}

# Quick directory size summary
def du-summary [path = "."] {
    try {
        du $path
        | sort-by size -r
        | first 10
        | update size { |row| $row.size | into string | str replace "B" "" | into filesize }
    } catch {
        print "Error reading directory sizes"
    }
}

# Find large files
def find-large [size = "100MB"] {
    fd -t f -S +$size . | each { |file| { name: $file, size: (ls $file | get size | first) } } | sort-by size -r
}

# Git log with better formatting
def git-log [n = 10] {
    git log --oneline -n $n | lines | each { |line|
        let parts = ($line | split column " " commit message)
        {
            commit: ($parts.commit | str substring 0..7),
            message: ($parts.message | str join " ")
        }
    }
}
