function la -w ls -d "List contents of directory, including hidden files, in long format"
    command ls --color=always --group-directories-first -lAh $argv
end
