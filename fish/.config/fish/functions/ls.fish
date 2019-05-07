function ls -w ls -d "List contents of directory, including hidden files, in long format"
    command ls -v --color=always --group-directories-first $argv
end
