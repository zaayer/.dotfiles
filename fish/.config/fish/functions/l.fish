function l -w ls -d "List contents of directory, including hidden files, in one line"
    command ls --color=always --group-directories-first -1A $argv
end
