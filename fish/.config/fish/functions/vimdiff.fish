function vimdiff -w nvim -d "Overwrites vimdiff with nvim diff."
    command nvim -d $argv
end
